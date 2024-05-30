//
//  BetterBoxdApp.swift
//  BetterBoxd
//
//  Created by Shiina on 5/20/24.
//

import SwiftUI

@main
struct BetterBoxdApp: App {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.blue

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.yellow]

        appearance.stackedLayoutAppearance = itemAppearance
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance

        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor.blue
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
