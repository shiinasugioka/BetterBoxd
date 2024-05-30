//
//  MainView.swift
//  BetterBoxd
//
//  Created by Shiina on 5/28/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Group {
                NavigationView {
                    HomePage()
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                NavigationView {
                    MoviesPage()
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                
                NavigationView {
                    ProfilePage()
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            }
            .toolbarBackground(Material.ultraThin, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .accentColor(.foregroundWhite)
    }
}

#Preview {
    MainView()
}

