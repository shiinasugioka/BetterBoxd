import Foundation
import Auth0
import RealmSwift

class AuthController: ObservableObject {
    @Published var isAuthenticated = false
    @Published var userProfile: Profile = .empty
    
    func login() {
        Auth0
            .webAuth()
            .scope("openid profile email")
            .audience("https://dev-g2d8118qv6ehbcyp.us.auth0.com/userinfo")
            .start { result in
                switch result {
                case .failure(let error):
                    print("Failed with \(error)")
                case .success(let credentials):
                    self.isAuthenticated = true
                    let profile = Profile.from(credentials.idToken)
                    
                    if let existingProfile = Profile.fetchUserProfileFromRealm(withId: profile.id) {
                        self.userProfile = existingProfile
                    } else {
                        self.saveUserProfileToRealm(profile)
                        self.userProfile = profile
                    }
                }
            }
    }
    
    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .failure(let error):
                    print("Failed with: \(error)")
                case .success:
                    self.isAuthenticated = false
                    self.userProfile = .empty
                }
            }
    }
    
    private func saveUserProfileToRealm(_ profile: Profile) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(profile)
        }
    }
}
