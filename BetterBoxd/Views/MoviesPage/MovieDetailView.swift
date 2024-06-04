import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if let url = movie.posterURL {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 300)
                                .clipped()
                                .cornerRadius(10)
                                .padding(.horizontal)
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        Color.gray
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                    }

                    Text(movie.title)
                        .font(.title)
                        .bold()
                        .padding(.top)
                        .padding(.horizontal)
                    
                    Text("The story of banker Andy Dufresne (Tim Robbins), who is sentenced to life in Shawshank State Penitentiary for the murders of his wife and her lover, despite his claims of innocence.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.horizontal)

                    HStack {
                        Spacer()
                        Button(action: {
                            // Favorite action
                        }) {
                            Image(systemName: "heart")
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal)
                        Button(action: {
                            // Add to watchlist action
                        }) {
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 5)

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
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Dismiss the modal
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Search action
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}
