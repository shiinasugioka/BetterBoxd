import SwiftUI
import RealmSwift

struct AddReviewView: View {
    var movieTitle: String
    var backgroundURL: URL?
    var movieID: Int // Add this to get the movie ID
    @State private var rating: Int = 0
    @State private var reviewText: String = ""
    var userId: String // Add this to get the user ID
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            if let backgroundURL = backgroundURL {
                AsyncImage(url: backgroundURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .blur(radius: 20)
                        .clipped()
                        .opacity(0.5)
                } placeholder: {
                    Color.gray
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                }
            } else {
                Color.gray
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }

            VStack(alignment: .leading) {
                HStack {
                    ForEach(1..<6) { star in
                        Image(systemName: self.rating >= star ? "star.fill" : "star")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                self.rating = star
                            }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 120)

                Text("Notes")
                    .font(.headline)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)

                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.5))
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)

                    TextEditor(text: $reviewText)
                        .padding()
                        .background(Color.clear)
                        .foregroundColor(.black)
                }
                .frame(height: 200)
                .padding(.horizontal, 20)
                .padding(.top, 10)

    

                HStack {

                    Button(action: {
                        print("Submit Review button clicked")
                        addReview()
                    }) {
                        Text("Submit Review")
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(20)
                            .padding(.horizontal, 50)
                    }
                    Spacer()
                }
                .padding(.bottom, 40)
            }
            .background(Color.black.opacity(0.7).edgesIgnoringSafeArea(.all))
            .navigationTitle(movieTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addReview() {
        print("Adding review to Realm")
        let review = Review()
        
        do {
            let realm = try Realm()
            
            // Fetch the existing user object
            guard let user = realm.object(ofType: Profile.self, forPrimaryKey: userId) else {
                print("User not found")
                print(userId)
                return
            }
            
            review.profile = user
            review.movieID = movieID // Replace with actual movie ID
            review.rating = rating
            review.reviewText = reviewText
            
            try realm.write {
                realm.add(review)
                print("Review added to Realm")
            }
        } catch let error {
            print("Failed to add review to Realm: \(error.localizedDescription)")
        }
        
        // Close all modals and go to profile page
        presentationMode.wrappedValue.dismiss()
    }
}


struct MovieDetailView: View {
    let movie: Movie
    let userId: String // Add this to pass the user ID
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    if let backgroundURL = movie.backdropURL {
                        AsyncImage(url: backgroundURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .blur(radius: 20)
                                .clipped()
                        } placeholder: {
                            Color.gray
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    } else {
                        Color.gray
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }

                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer()
                                if let url = movie.posterURL {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geometry.size.width * 0.7)
                                            .cornerRadius(20)
                                            .clipped()
                                            .shadow(radius: 10)
                                            .padding(.top, 100)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: geometry.size.width * 0.7, height: 300)
                                            .cornerRadius(20)
                                            .shadow(radius: 10)
                                            .padding(.top, 100)
                                    }
                                } else {
                                    Color.gray
                                        .frame(width: geometry.size.width * 0.7, height: 300)
                                        .cornerRadius(20)
                                        .padding(.top, 20)
                                        .shadow(radius: 10)
                                }
                                Spacer()
                            }

                            ZStack {
                                Color.black.opacity(0.2)
                                    .cornerRadius(10)
                                
                                HStack {
                                    Text(movie.title)
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()

                                    Spacer()

                                    HStack(spacing: 10) {
                                        Button(action: {
                                            // Favorite action
                                        }) {
                                            Image(systemName: "heart")
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.clear)
                                                .clipShape(Circle())
                                        }

                                        Button(action: {
                                            // Add to watchlist action
                                        }) {
                                            Image(systemName: "plus")
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.clear)
                                                .clipShape(Circle())
                                        }
                                    }
                                    .padding()
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)

                            ZStack {
                                Color.black.opacity(0.2)
                                    .cornerRadius(10)
                                
                                Text(movie.overview)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)

                            Spacer()

                            HStack {
                                Spacer()
                                NavigationLink(destination: AddReviewView(movieTitle: movie.title, backgroundURL: movie.backdropURL, movieID: movie.id, userId: self.userId)) {
                                    Text("Add your Review")
                                        .font(.headline)
                                        .padding(.horizontal, 30)
                                        .padding(.vertical, 10)
                                        .background(
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(Color.white.opacity(0.2))
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(
                                                        LinearGradient(
                                                            gradient: Gradient(colors: [Color.red, Color.yellow, Color.green, Color.blue]),
                                                            startPoint: .leading,
                                                            endPoint: .trailing
                                                        ),
                                                        lineWidth: 1
                                                    )
                                            }
                                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 2)
                                        )
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 40)
                        }
                        .padding(.bottom, 50)
                    }
                }
                .background(Color.white.opacity(0.1))
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ZStack {
                            Color.white.opacity(0.7)
                                .cornerRadius(10)
                            
                            Text(movie.title)
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding()
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
}

extension Movie {
    var backdropURL: URL? {
        if let path = backdropPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        }
        return nil
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView(movie: Movie(id: 0, title: "Sample Movie", overview: "This is a sample movie overview.", posterPath: "/samplePoster.jpg", releaseDate: nil, adult: false, backdropPath: "/sampleBackdrop.jpg", genreIds: [], originalLanguage: "en", originalTitle: "", popularity: 0.0, video: false, voteAverage: 0.0, voteCount: 0), userId: self.userId)
//            .previewDevice("iPhone 12")
//        MovieDetailView(movie: Movie(id: 0, title: "Sample Movie", overview: "This is a sample movie overview.", posterPath: "/samplePoster.jpg", releaseDate: nil, adult: false, backdropPath: "/sampleBackdrop.jpg", genreIds: [], originalLanguage: "en", originalTitle: "", popularity: 0.0, video: false, voteAverage: 0.0, voteCount: 0), userId: self.userId)
//            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
//    }
//}
