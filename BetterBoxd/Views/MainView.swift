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

#Preview {
    MainView()
}

