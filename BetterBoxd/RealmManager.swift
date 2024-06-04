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
    
    private init() {
        // use this to connect to realm studio
        let realm = try! Realm()
        print("Realm is located at:", realm.configuration.fileURL!)
        
        let appId = Bundle.main.object(forInfoDictionaryKey: "REALM_APP_ID") as! String
        self.app = RealmSwift.App(id: appId)
    }
    
    func getConfiguration() -> Realm.Configuration {
        return Realm.Configuration()
    }

    
    func addUser(name: String, email: String) {
        let user = User()
        user.name = name
        user.email = email
        
        print("User added successfully")
    }
}
