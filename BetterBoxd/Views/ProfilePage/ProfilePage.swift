import SwiftUI

struct ProfilePage: View {
    @Binding var profile: Profile
    @ObservedObject var viewModel: MoviesViewModel
    
    init(profile: Binding<Profile>) {
        self._profile = profile
        self.viewModel = MoviesViewModel(userId: profile.wrappedValue.id)
    }
    
    var body: some View {
        ZStack {
            Color.darkBlue.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(profile.name)
                    .font(.largeTitle)
                    .foregroundColor(.foregroundWhite)
                
                Text(profile.username)
                    .font(.title2)
                    .foregroundColor(.foregroundWhite)
                
                if !profile.bio.isEmpty {
                    Text(profile.bio)
                        .font(.body)
                        .foregroundColor(.foregroundWhite)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.popularMovies) { movie in
                            MovieCard(movie: movie)
                                
                        }
                    }
                    .padding(.horizontal)
                }
                
                if !viewModel.reviewedMovies.isEmpty {
                    Text("Reviewed Movies")
                        .font(.headline)
                        .foregroundColor(.foregroundWhite)
                        .padding(.top)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                            ForEach(viewModel.reviewedMovies) { movie in
                                VStack {
                                    if let posterURL = movie.posterURL {
                                        AsyncImage(url: posterURL) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 150)
                                                .cornerRadius(10)
                                                .clipped()
                                        } placeholder: {
                                            Color.gray
                                                .frame(width: 100, height: 150)
                                                .cornerRadius(10)
                                        }
                                    } else {
                                        Color.gray
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(10)
                                    }
                                    Text(movie.title)
                                        .font(.caption)
                                        .foregroundColor(.foregroundWhite)
                                        .lineLimit(1)
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    Text("No reviews yet.")
                        .font(.subheadline)
                        .foregroundColor(.foregroundWhite)
                        .padding(.top)
                }
            }
        }
        .onAppear {
            viewModel.fetchReviewedMovies(for: profile.id)
            // Log the reviewedMovies list
            print("Reviewed Movies: \(viewModel.reviewedMovies.map { $0.title })")
        }
        .onChange(of: viewModel.reviewedMovies) { newValue in
            // Log the reviewedMovies list when it changes
            print("Updated Reviewed Movies: \(newValue.map { $0.title })")
        }
    }
}

// Uncomment below for SwiftUI previews
//struct ProfilePage_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePage(profile: .constant(Profile(
//            id: "sampleUserId",
//            name: "Sample Name",
//            username: "sampleUsername",
//            bio: "Sample bio",
//            email: "sample@example.com",
//            emailVerified: true,
//            picture: "",
//            updatedAt: "",
//            isPrivate: false
//        )))
//            .previewDevice("iPhone 12")
//        ProfilePage(profile: .constant(Profile(
//            id: "sampleUserId",
//            name: "Sample Name",
//            username: "sampleUsername",
//            bio: "Sample bio",
//            email: "sample@example.com",
//            emailVerified: true,
//            picture: "",
//            updatedAt: "",
//            isPrivate: false
//        )))
//            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
//    }
//}
