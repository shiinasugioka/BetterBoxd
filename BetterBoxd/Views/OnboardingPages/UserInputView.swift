//
//  UserInputView.swift
//  BetterBoxd
//
//  Created by Ahmed Ghaddah on 6/3/24.
//

import SwiftUI

struct UserInputView: View {
    @Binding var profile: Profile
    @Binding var currentStep: OnboardingStep
    
    var body: some View {
        VStack {
            HStack {
                Text("Create Username")
                    .font(.title)
                    .fontWeight(.regular)
                    .kerning(1.4)
            }
            .padding(.top, 80)
            
            Text("Add a username. You can change this any time.")
                .foregroundColor(.gray)
                .padding(.top, 0.5)
                .padding(.horizontal, 20)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            TextField("Username", text: $profile.username)
                .padding()
                .background(Color.fromHex("#F9F9F9"))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.fromHex("#E0E0E0"), lineWidth: 1)
                )
                .font(.system(size: 14))
                .foregroundColor(Color.fromHex("#333333"))
                .padding(.horizontal, 20)
                .padding(.top, 30)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Spacer(minLength: 0)
            
            HStack {
                Color.gray.frame(height: 8 / UIScreen.main.scale)
                Color.green.frame(height: 8 / UIScreen.main.scale)
                Color.gray.frame(height: 8 / UIScreen.main.scale)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            
            Button(action: {
                //TODO: inputbio
            }, label: {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(40)
                    .padding(.horizontal, 50)
            })
            
            Text("By signing up, you agree to our Terms.")
                .padding()
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
    }
}

struct UserInputView_Previews: PreviewProvider {
    @State static var profile = Profile.empty
    @State static var currentStep = OnboardingStep.username
    
    static var previews: some View {
        UserInputView(profile: $profile, currentStep: $currentStep)
    }
}
