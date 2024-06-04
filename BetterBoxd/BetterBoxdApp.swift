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
        _ = RealmManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.realmConfiguration, RealmManager.shared.getConfiguration())
        }
    }
}
