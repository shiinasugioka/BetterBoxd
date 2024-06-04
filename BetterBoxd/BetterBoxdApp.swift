//
//  BetterBoxdApp.swift
//  BetterBoxd
//
//  Created by Shiina on 5/20/24.
//

import SwiftUI
import RealmSwift

@main
struct BetterBoxdApp: SwiftUI.App {
    init() {
        if let appId = Bundle.main.object(forInfoDictionaryKey: "REALM_APP_ID") as? String {
            let realmApp = RealmSwift.App(id: appId)
            
        } else {
            fatalError("REALM_APP_ID not found in Info.plist")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
