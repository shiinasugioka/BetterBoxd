import SwiftUI
import RealmSwift

struct MainView: View {
    @Binding var profile: Profile
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.realmConfiguration) var config: Realm.Configuration
    
    var body: some View {
        TabView {
            NavigationView {
                HomePage(profile: $profile)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            NavigationView {
                MoviesPage(profile: $profile)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            NavigationView {
                ProfilePage(profile: $profile)
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
            
            
            profile.updateUserProfileInRealm(userProfile: profile)
        }
    }
    
}


struct Sidebar: View {
    @Binding var profile: Profile
    
    var body: some View {
        List {
            NavigationLink(destination: HomePage(profile: $profile)) {
                Label("Home", systemImage: "house.fill")
            }
            NavigationLink(destination: MoviesPage(profile: $profile)) {
                Label("Search", systemImage: "magnifyingglass")
            }
            NavigationLink(destination: ProfilePage(profile: $profile)) {
                Label("Profile", systemImage: "person.fill")
            }
        }
        .listStyle(SidebarListStyle())
    }
}

// #Preview {
//     MainView()
//         .environment(\.realmConfiguration, RealmManager.shared.getConfiguration())
//         }
//     }
// }

//struct MainView_Previews: PreviewProvider {
// @State var profile = Profile.empty
//
//    static var previews: some View {
//        MainView(profile: $profile)
//            .previewDevice("iPhone 12")
//        MainView(profile: $profile)
//            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
//    }
//}
