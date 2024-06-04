//
//  OnboardingView.swift
//  BetterBoxd
//
//  Created by Ahmed Ghaddah on 6/3/24.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var profile: Profile
    @State private var currentStep: OnboardingStep = .welcome
    
    var body: some View {
        OnboardingScreen(profile: $profile, currentStep: $currentStep)
    }
}

struct OnboardingScreen: View {
    @Binding var profile: Profile
    @Binding var currentStep: OnboardingStep
    
    var body: some View {
        VStack {
            switch currentStep {
            case .welcome:
                IntroScreenView(currentStep: $currentStep)
            case .username:
                UserInputView(profile: $profile, currentStep: $currentStep)
            case .bio:
                BioInputView(profile:$profile, currentStep: $currentStep)
            case .complete:
                MainView(profile:$profile)
            }
        }
    }
}

struct IntroScreenView: View {
    @Binding var currentStep: OnboardingStep
    
    var body: some View {
        VStack {
            HStack {
                Text("Welcome!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .kerning(1.4)
                Spacer()
            }
            .padding()
            Spacer()
            Image("movie-chair")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 16)
                .frame(width: 300, height: 300)
            Spacer(minLength: 80)
            Text("Let's Get You Started!")
                .font(.title)
                .fontWeight(.bold)
                .kerning(1.2)
                .padding(.top)
                .padding(.bottom, 5)
            Text("This is the new way to review movies. We want to give you the most seamless, and easy way to share your reviews with friends.")
                .kerning(0.2)
                .padding([.leading, .trailing])
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Spacer()
            HStack {
                Color.green.frame(height: 8 / UIScreen.main.scale)
                Color.gray.frame(height: 8 / UIScreen.main.scale)
                
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            
            Button(action: {
                withAnimation {
                    currentStep = .username
                }
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
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    @State static var profile = Profile.empty
    
    static var previews: some View {
        OnboardingView(profile: $profile)
    }
}
