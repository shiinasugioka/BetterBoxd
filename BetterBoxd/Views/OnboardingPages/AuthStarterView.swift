//
//  AuthStarterView.swift
//  BetterBoxd
//
//  Created by Ahmed Ghaddah on 6/3/24.
//

//
//  AuthStarterView.swift
//  BetterBoxdAuth
//
//  Created by Ahmed Ghaddah on 5/31/24.
//

import SwiftUI
import Auth0

struct AuthStarterView: View {
    @StateObject private var authViewModel = AuthController()
    
    var body: some View {
        NavigationView {
            if authViewModel.isAuthenticated {
                  if authViewModel.userProfile.username.isEmpty {
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
                        .padding(.horizontal, 16)
                        .frame(width: 300, height: 300)
                    BottomPartView(loginAction: {
                        authViewModel.login()
                    })
                }
                .background(Color.darkBlue.edgesIgnoringSafeArea(.all))
            }
        }
    }
}

struct BottomPartView: View {
    var loginAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .frame(height: 250)
                .overlay(
                    VStack(alignment: .leading, spacing: 16) {
                        Text("The Best Movie Reviews")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 40)
                        
                        Text("Unlock a world of possibilities as you effortlessly journal all your favorite movies")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                        Spacer()
                        
                        Button(action: {
                            loginAction()
                        }) {
                            Text("Log in")
                                .fontWeight(.semibold)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(20)
                                .padding(.horizontal, 50)
                        }
                    }
                    .padding()
                )
                .padding(.horizontal)
        }
    }
}

    
    struct AuthStarterView_Previews: PreviewProvider {
        static var previews: some View {
            AuthStarterView()
        }
    }

