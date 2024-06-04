import SwiftUI
import RealmSwift

struct MainView: View {
    @Binding var profile: Profile
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.realmConfiguration) var config: Realm.Configuration

    var body: some View {
        TabView {
            NavigationView {
                if horizontalSizeClass == .compact {
                    HomePage(profile: $profile)
                } else {
                    Sidebar(profile: $profile)
                    HomePage(profile: $profile) // Default content
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
                    Sidebar(profile: $profile)
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
                    Sidebar(profile: $profile)
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

            addUser()
        }
    }

    func addUser() {
        let realm = try! Realm(configuration: config)

        if realm.objects(User.self).filter("id = %@", "dummyUserId").first == nil {
            try! realm.write {
                let dummyUser = User()
                dummyUser.id = "dummyUserId"
                realm.add(dummyUser)
            }
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

// #Preview {
//     MainView()
//         .environment(\.realmConfiguration, RealmManager.shared.getConfiguration())
// }

