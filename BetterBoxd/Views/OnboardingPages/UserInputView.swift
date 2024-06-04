//import SwiftUI
//
//struct UserInputView: View {
//    @Binding var profile: Profile
//    @Binding var currentStep: OnboardingStep
//    @State private var tempUsername: String = ""
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Create Username")
//                    .font(.title)
//                    .fontWeight(.regular)
//                    .kerning(1.4)
//            }
//            .padding(.top, 80)
//            
//            Text("Add a username. You can change this any time.")
//                .foregroundColor(.gray)
//                .padding(.top, 0.5)
//                .padding(.horizontal, 20)
//                .font(.subheadline)
//                .multilineTextAlignment(.center)
//            
//            TextField("Username", text: $tempUsername)
//                .padding()
//                .background(Color.fromHex("#F9F9F9"))
//                .cornerRadius(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.fromHex("#E0E0E0"), lineWidth: 1)
//                )
//                .font(.system(size: 14))
//                .foregroundColor(Color.fromHex("#333333"))
//                .padding(.horizontal, 20)
//                .padding(.top, 30)
//                .frame(minWidth: 0, maxWidth: .infinity)
//
//            
//            Spacer(minLength: 0)
//            
//            HStack {
//                Color.gray.frame(height: 8 / UIScreen.main.scale)
//                Color.green.frame(height: 8 / UIScreen.main.scale)
//                Color.gray.frame(height: 8 / UIScreen.main.scale)
//            }
//            .padding(.horizontal, 30)
//            .padding(.bottom, 30)
//            
//            Button(action: {
//                // Update the profile's username when "Next" is pressed
//                profile.username = tempUsername
//                currentStep = .bio
//            }, label: {
//                Text("Next")
//                    .fontWeight(.semibold)
//                    .frame(minWidth: 0, maxWidth: .infinity)
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.green)
//                    .cornerRadius(40)
//                    .padding(.horizontal, 50)
//            })
//            
//            Text("By signing up, you agree to our Terms.")
//                .padding()
//                .font(.caption2)
//                .foregroundColor(.gray)
//        }
//        .padding(.horizontal, 20)
//        .onAppear {
//            // Initialize the temporary username with the current profile username
//            self.tempUsername = self.profile.username
//        }
//        
//        
//    }
//}
//
//struct UserInputView_Previews: PreviewProvider {
//    @State static var profile = Profile.empty
//    @State static var currentStep = OnboardingStep.username
//    
//    static var previews: some View {
//        UserInputView(profile: $profile, currentStep: $currentStep)
//    }
//}

//import SwiftUI
//
//struct UserInputView: View {
//    @Binding var profile: Profile
//    @Binding var currentStep: OnboardingStep
//    @State private var tempUsername: String = ""
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Add Some Spice!")
//                    .font(.title)
//                    .fontWeight(.regular)
//                    .kerning(1.4)
//            }
//            .padding(.top, 80)
//            
//            Text("Add a username & Bio. You can change this any time.")
//                .foregroundColor(.gray)
//                .padding(.top, 0.5)
//                .padding(.horizontal, 20)
//                .font(.subheadline)
//                .multilineTextAlignment(.center)
//            
//            TextField("Username", text: $tempUsername)
//                .padding()
//                .background(Color.fromHex("#F9F9F9"))
//                .cornerRadius(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.fromHex("#E0E0E0"), lineWidth: 1)
//                )
//                .font(.system(size: 14))
//                .foregroundColor(Color.fromHex("#333333"))
//                .padding(.horizontal, 20)
//                .padding(.top, 30)
//                .frame(minWidth: 0, maxWidth: .infinity)
//            
//            TextField("Insert Bio Here..", text: $profile.bio)
//                .padding()
//                .background(Color.fromHex("#F9F9F9"))
//                .cornerRadius(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.fromHex("#E0E0E0"), lineWidth: 1)
//                )
//                .font(.system(size: 14))
//                .foregroundColor(Color.fromHex("#333333"))
//                .padding(.horizontal, 20)
//                .padding(.top, 30)
//                .frame(minWidth: 0, maxWidth: .infinity)
//            
//            
//            
//            Toggle(isOn: $profile.isPrivate) {
//                            Text("Private Profile")
//                                .foregroundColor(Color.fromHex("#333333"))
//                                .padding(.top, 16)
//                        }
//                        .padding(.horizontal, 20)
//                        .padding(.top, 40)
//                        
//            
//            Spacer(minLength: 0)
//            
//            HStack {
//                Color.gray.frame(height: 8 / UIScreen.main.scale)
//                Color.green.frame(height: 8 / UIScreen.main.scale)
//            }
//            .padding(.horizontal, 30)
//            .padding(.bottom, 30)
//            
//            Button(action: {
//                // Update the profile's username when "Next" is pressed
//                profile.username = tempUsername
//                currentStep = .complete
//            }, label: {
//                Text("Next")
//                    .fontWeight(.semibold)
//                    .frame(minWidth: 0, maxWidth: .infinity)
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.green)
//                    .cornerRadius(40)
//                    .padding(.horizontal, 50)
//            })
//            
//            Text("By signing up, you agree to our Terms.")
//                .padding()
//                .font(.caption2)
//                .foregroundColor(.gray)
//        }
//        .padding(.horizontal, 20)
//        
//        
//        .onAppear {
//            // Initialize the temporary username with the current profile username
//            self.tempUsername = self.profile.username
//        }
//    }
//}
//
//struct UserInputView_Previews: PreviewProvider {
//    @State static var profile = Profile.empty
//    @State static var currentStep = OnboardingStep.username
//    
//    static var previews: some View {
//        UserInputView(profile: $profile, currentStep: $currentStep)
//    }
//}

import SwiftUI

struct UserInputView: View {
    @Binding var profile: Profile
    @Binding var currentStep: OnboardingStep
    @State private var tempUsername: String = ""
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Add Some Spice!")
                .font(.title)
                .fontWeight(.regular)
                .kerning(1.4)

            Text("Add a username & Bio. You can change this any time.")
                .foregroundColor(.gray)
                .font(.subheadline)
                .multilineTextAlignment(.leading)

            TextField("Username", text: $tempUsername)
                .padding(.horizontal)
                .background(Color.fromHex("#F9F9F9"))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.fromHex("#E0E0E0"), lineWidth: 1)
                )
                .font(.system(size: 14))
                .foregroundColor(Color.fromHex("#333333"))

            TextField("Insert Bio Here..", text: $profile.bio)
                .padding(.horizontal)
                .background(Color.fromHex("#F9F9F9"))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.fromHex("#E0E0E0"), lineWidth: 1)
                )
                .font(.system(size: 14))
                .foregroundColor(Color.fromHex("#333333"))

            Toggle(isOn: $profile.isPrivate) {
                Text("Private Profile")
                    .foregroundColor(Color.fromHex("#333333"))
            }
            .padding(.horizontal)

            Spacer()

            ProgressView(value: 1, total: 2)
                .padding(.horizontal)

            Button(action: {
                profile.username = tempUsername
                currentStep = .complete
            }, label: {
                Text("Next")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(40)
            })

            Text("By signing up, you agree to our Terms.")
                .padding()
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding()
        .onAppear {
            self.tempUsername = self.profile.username
        }
    }
}
