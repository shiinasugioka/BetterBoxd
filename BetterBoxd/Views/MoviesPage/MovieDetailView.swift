import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
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
                                Button(action: {
                                    // Add review action
                                }) {
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
                            // Dismiss the modal
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

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(id: 0, title: "Sample Movie", overview: "This is a sample movie overview.", posterPath: "/samplePoster.jpg", backdropPath: "/sampleBackdrop.jpg"))
            .previewDevice("iPhone 12")
        MovieDetailView(movie: Movie(id: 0, title: "Sample Movie", overview: "This is a sample movie overview.", posterPath: "/samplePoster.jpg", backdropPath: "/sampleBackdrop.jpg"))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}
