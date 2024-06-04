//
//  BioInputView.swift
//  BetterBoxd
//
//  Created by Ahmed Ghaddah on 6/3/24.
//

import SwiftUI

struct BioInputView: View {
    @Binding var profile: Profile
    @Binding var currentStep: OnboardingStep
    
    var body: some View {
        VStack {
            HStack {
                Text("Create Your Bio")
                    .font(.title)
                    .fontWeight(.regular)
                    .kerning(1.4)
            }
            .padding(.top, 80)
            
            Text("Add a bio. You can change this any time.")
                .foregroundColor(.gray)
                .padding(.top, 0.5)
                .padding(.horizontal, 20)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            TextField("Insert Bio Here..", text: $profile.bio)
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
            
            
            
            Toggle(isOn: $profile.isPrivate) {
                            Text("Private Profile")
                                .foregroundColor(Color.fromHex("#333333"))
                                .padding(.top, 16)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 40)
                        
            
            
            Spacer(minLength: 0)
            
                        
            
            HStack {
                Color.gray.frame(height: 8 / UIScreen.main.scale)
                Color.gray.frame(height: 8 / UIScreen.main.scale)
                Color.green.frame(height: 8 / UIScreen.main.scale)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            
            Button(action: {
                // Action for the next step
                withAnimation {
                    currentStep = .complete
                }
            }, label: {
                Text("Start Now")
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

struct BioInputView_Previews: PreviewProvider {
    @State static var profile = Profile.empty
    @State static var currentStep = OnboardingStep.bio
    
    static var previews: some View {
        BioInputView(profile: $profile, currentStep: $currentStep)
    }
}
