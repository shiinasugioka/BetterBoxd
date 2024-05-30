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
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        Color.gray
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                    }

                    Text(movie.title)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)

                    Text(movie.overview)
                        .font(.body)
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
            }
        }
    }
}
