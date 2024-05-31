import Foundation
import Auth0
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var profile: Profile?
    @Published var isAuthenticated = false

    private let clientId = "YOUR_CLIENT_ID"
    private let domain = "YOUR_DOMAIN"

    func login() {
        Auth0
            .webAuth()
            .scope("openid profile email")
            .audience("https://\(domain)/userinfo")
            .start { result in
                switch result {
                case .failure(let error):
                    print("Failed with: \(error)")
                case .success(let credentials):
                    self.isAuthenticated = true
                    self.fetchProfile(credentials: credentials)
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
                    self.profile = nil
                }
            }
    }

    private func fetchProfile(credentials: Credentials) {
        Auth0
            .authentication(clientId: clientId, domain: domain)
            .userInfo(withAccessToken: credentials.accessToken!)
            .start { result in
                switch result {
                case .failure(let error):
                    print("Failed to fetch user profile with: \(error)")
                case .success(let userInfo):
                    DispatchQueue.main.async {
                        self.profile = Profile(
                            id: userInfo.sub,
                            name: userInfo.name ?? "No Name",
                            email: userInfo.email ?? "No Email",
                            picture: userInfo.picture
                        )
                    }
                }
            }
    }
}
