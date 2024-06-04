import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

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

                        HStack {
                            Text(movie.title)
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading, 20)

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
                            .padding(.trailing, 20)
                        }

                        Text(movie.overview)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.top, 5)
                            .padding(.horizontal, 20)

                        Spacer()

                        Button(action: {
                            // Add your review action
                        }) {
                            Text("Add your Review")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.bottom, 30)
                }
            }
            .background(Color.black.opacity(0.6))
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Dismiss the modal
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

