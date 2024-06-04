import SwiftUI

struct MainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        TabView {
            NavigationView {
                if horizontalSizeClass == .compact {
                    HomePage()
                } else {
                    Sidebar()
                    HomePage() // Default content
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            NavigationView {
                if horizontalSizeClass == .compact {
                    MoviesPage()
                } else {
                    Sidebar()
                    MoviesPage()
                }
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            NavigationView {
                if horizontalSizeClass == .compact {
                    ProfilePage()
                } else {
                    Sidebar()
                    ProfilePage()
                }
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
        .accentColor(.foregroundWhite)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.darkBlue.opacity(0.2))
            appearance.shadowColor = UIColor(Color.salmonPink)
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: HomePage()) {
                Label("Home", systemImage: "house.fill")
            }
            NavigationLink(destination: MoviesPage()) {
                Label("Search", systemImage: "magnifyingglass")
            }
            NavigationLink(destination: ProfilePage()) {
                Label("Profile", systemImage: "person.fill")
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice("iPhone 12")
        MainView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}
