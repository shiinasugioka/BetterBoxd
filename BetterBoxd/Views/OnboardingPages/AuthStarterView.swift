////
////  AuthStarterView.swift
////  BetterBoxd
////
////  Created by Ahmed Ghaddah on 6/3/24.
////
//
//import SwiftUI
//import Auth0
//import RealmSwift
//
//struct AuthStarterView: View {
//    @StateObject private var authViewModel = AuthController()
//    
//    var body: some View {
//        NavigationView {
//            if authViewModel.isAuthenticated {
//                if isUsernameEmpty() {
//                    // Navigate to OnboardingView if username is empty
//                    OnboardingView(profile: $authViewModel.userProfile)
//                } else {
//                    // Navigate to MainView if username is not empty
//                    MainView(profile: $authViewModel.userProfile)
//                }
//            } else {
//                VStack {
//                    Image("glasses")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(.horizontal, 16)
//                        .frame(width: 300, height: 300)
//                    BottomPartView(loginAction: {
//                        authViewModel.login()
//                    })
//                }
//                .background(Color.darkBlue.edgesIgnoringSafeArea(.all))
//            }
//        }
//    }
//    
//    private func isUsernameEmpty() -> Bool {
//        let realm = try! Realm()
//        if let existingProfile = realm.object(ofType: Profile.self, forPrimaryKey: authViewModel.userProfile.id) {
//            return existingProfile.username.isEmpty
//        }
//        return true
//    }
//}
//
//struct BottomPartView: View {
//    var loginAction: () -> Void
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                .fill(Color.white)
//                .frame(height: 250)
//                .overlay(
//                    VStack(alignment: .leading, spacing: 16) {
//                        Text("The Best Movie Reviews")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .foregroundColor(.black)
//                            .padding(.horizontal, 40)
//                        
//                        Text("Unlock a world of possibilities as you effortlessly journal all your favorite movies")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                            .multilineTextAlignment(.center)
//                            .padding(.horizontal, 20)
//                        Spacer()
//                        
//                        Button(action: {
//                            loginAction()
//                        }) {
//                            Text("Log in")
//                                .fontWeight(.semibold)
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.green)
//                                .cornerRadius(20)
//                                .padding(.horizontal, 50)
//                        }
//                    }
//                    .padding()
//                )
//                .padding(.horizontal)
//        }
//    }
//}
//
//struct AuthStarterView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthStarterView()
//    }
//}

import SwiftUI
import Auth0
import RealmSwift

struct AuthStarterView: View {
    @StateObject private var authViewModel = AuthController()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        NavigationView {
            if authViewModel.isAuthenticated {
                if isUsernameEmpty() {
                    // Navigate to OnboardingView if username is empty
                    OnboardingView(profile: $authViewModel.userProfile)
                } else {
                    // Navigate to MainView if username is not empty
                    MainView(profile: $authViewModel.userProfile)
                }
            } else {
                VStack {
                    Image("glasses")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Spacer()
                    BottomPartView(loginAction: {
                        authViewModel.login()
                    }, horizontalSizeClass: horizontalSizeClass)
                }
                .background(Color.darkBlue.edgesIgnoringSafeArea(.all))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }

    private func isUsernameEmpty() -> Bool {
        let realm = try! Realm()
        if let existingProfile = realm.object(ofType: Profile.self, forPrimaryKey: authViewModel.userProfile.id) {
            return existingProfile.username.isEmpty
        }
        return true
    }
}

struct BottomPartView: View {
    var loginAction: () -> Void
    var horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .overlay(
                    VStack(alignment: .center, spacing: 16) {
                        Text("The Best Movie Reviews")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Unlock a world of possibilities as you effortlessly journal all your favorite movies")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button(action: loginAction) {
                            Text("Log in")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: horizontalSizeClass == .compact ? .infinity : 300)
                                .background(Color.green)
                                .cornerRadius(20)
                        }
                    }
                    .padding()
                )
                .padding()
        }
    }
}

struct AuthStarterView_Previews: PreviewProvider {
    static var previews: some View {
        AuthStarterView()
    }
}
