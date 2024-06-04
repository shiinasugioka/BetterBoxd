import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        NavigationView {
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
                                    .padding(.top, 20)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: UIScreen.main.bounds.width * 0.7, height: 300)
                                    .cornerRadius(20)
                                    .shadow(radius: 10)
                                    .padding(.top, 20)
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
                            .foregroundColor(.foregroundWhite)
                            .padding(.leading, 20)

                        Spacer()

                        HStack(spacing: 10) {
                            Button(action: {
                                // Favorite action
                            }) {
                                Image(systemName: "heart")
                                    .foregroundColor(.foregroundWhite)
                                    .padding()
                                    .background(Color.darkBlue)
                                    .clipShape(Circle())
                            }

                            Button(action: {
                                // Add to watchlist action
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.foregroundWhite)
                                    .padding()
                                    .background(Color.darkBlue)
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.trailing, 20)
                    }

                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.foregroundWhite)
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
            .background(
                VisualEffectBlur(effect: UIBlurEffect(style: .dark), intensity: 0.5)
                    .background(Color.darkBlue)
            )
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Dismiss the modal
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.foregroundWhite)
                    }
                }
            }
        }
    }
}
