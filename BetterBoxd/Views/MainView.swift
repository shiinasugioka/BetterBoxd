import SwiftUI

struct MainView: View {
    @Binding var profile: Profile
    var body: some View {
        TabView {
            Group {
                NavigationView {
                    HomePage(profile: $profile)
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

#Preview{
    @State var profile = Profile.empty
    
    MainView(profile: $profile)
}
