import SwiftUI

struct HomePage: View {
    @ObservedObject var viewModel = MoviesViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Popular Movies
                    Text("Popular Movies 🍿")
                        .font(.headline)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.popularMovies) { movie in
                                MovieCard(movie: movie)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
