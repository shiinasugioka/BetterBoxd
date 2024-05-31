import SwiftUI

struct ProfilePage: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            if let profile = authViewModel.profile {
                Text("Hello, \(profile.name)!")
                    .font(.largeTitle)

                if let picture = profile.picture {
                    AsyncImage(url: picture) { image in
                        image.resizable()
                             .frame(width: 100, height: 100)
                             .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text(profile.email)
                    .font(.subheadline)

                Button(action: {
                    authViewModel.logout()
                }) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            } else {
                Text("Loading profile...")
            }
        }
    }
}

#Preview {
    ProfilePage()
}
