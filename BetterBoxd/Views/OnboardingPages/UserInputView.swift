import SwiftUI
import RealmSwift

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
                let realm = try! Realm()
                try! realm.write {
                    profile.username = tempUsername
                    currentStep = .complete
                }
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
