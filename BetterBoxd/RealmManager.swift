//
//  RealmManager.swift
//  BetterBoxd
//
//  Created by Shiina on 6/3/24.
//

import RealmSwift
import Foundation

class RealmManager {
    static let shared = RealmManager()
    let app: RealmSwift.App?
    var localRealm: Realm? // until auth0 is set up
    
    private init() {
        // use this to connect to realm studio
        let realm = try! Realm()
        print("Realm is located at:", realm.configuration.fileURL!)
        
        if let appId = Bundle.main.object(forInfoDictionaryKey: "REALM_APP_ID") as? String {
            self.app = RealmSwift.App(id: appId)
        } else {
            self.app = nil
            setupLocalRealm()
        }
    }
    
    func getConfiguration() -> Realm.Configuration {
        if let user = app?.currentUser {
            return user.configuration(partitionValue: "user=\(user.id)")
        } else {
            return localRealmConfiguration()
        }
    }
    
    private func localRealmConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration()
        config.inMemoryIdentifier = "LocalRealm"
        return config
    }
    
    private func setupLocalRealm() {
        let config = localRealmConfiguration()
        do {
            localRealm = try Realm(configuration: config)
        } catch {
            fatalError("Failed to open local Realm: \(error.localizedDescription)")
        }
    }
    
    func addUser(name: String, email: String) {
        guard let localRealm = localRealm else {
            print("Local Realm is not set up")
            return
        }
        
        let user = User()
        user.name = name
        user.email = email
        
        do {
            try localRealm.write {
                localRealm.add(user)
            }
            print("User added successfully")
        } catch {
            print("Failed to add user: \(error.localizedDescription)")
        }
    }
}
