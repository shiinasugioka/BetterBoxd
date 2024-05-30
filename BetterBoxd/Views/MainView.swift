// Views/MainView.swift
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomePage()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
//            NavigationView {
//                MoviesPage()
//            }
//            .tabItem {
//                Image(systemName: "magnifyingglass")
//                Text("Search")
//            }
            
            NavigationView {
                ProfilePage()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
    }
}

#Preview {
    MainView()
}
