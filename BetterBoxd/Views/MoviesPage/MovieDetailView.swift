import SwiftUI

struct AddReviewView: View {
    var movieTitle: String
    var backgroundURL: URL?

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
                    ForEach(0..<5) { _ in
                        Image(systemName: "star")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 120)

                Text("Notes")
                    .font(.headline)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)

                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.5))
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)

                    TextEditor(text: .constant(""))
                        .padding()
                        .background(Color.clear)
                        .foregroundColor(.white)
                }
                .frame(height: 200)
                .padding(.horizontal, 20)
                .padding(.top, 10)

                Spacer()

                HStack {
                    Spacer()
                    Button(action: {
                        // Add review action
                    }) {
                        Image(systemName: "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button(action: {
                        // Add to watchlist action
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
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
}

struct MovieDetailView: View {
    let movie: Movie
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                if let backgroundURL = movie.backgroundURL {
                    AsyncImage(url: backgroundURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .blur(radius: 20)
                            .clipped()
                    } placeholder: {
                        Color.gray
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    }
                } else {
                    Color.gray
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
                                        .frame(width: UIScreen.main.bounds.width * 0.7)
                                        .cornerRadius(20)
                                        .clipped()
                                        .shadow(radius: 10)
                                        .padding(.top, 100)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 300)
                                        .cornerRadius(20)
                                        .shadow(radius: 10)
                                        .padding(.top, 100)
                                }
                            } else {
                                Color.gray
                                    .frame(width: UIScreen.main.bounds.width * 0.7, height: 300)
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
                            NavigationLink(destination: AddReviewView(movieTitle: movie.title, backgroundURL: movie.backgroundURL)) {
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

