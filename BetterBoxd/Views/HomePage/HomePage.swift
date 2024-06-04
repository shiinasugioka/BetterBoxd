import SwiftUI

struct HomePage: View {
    @ObservedObject var viewModel = MoviesViewModel()
    @State private var selectedMovie: Movie? = nil

    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBlue.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                        
                        if let upcomingMovie = viewModel.upcomingMovie {
                                        CountdownCard(movie: upcomingMovie, releaseDate: upcomingMovie.releaseDate ?? Date())
                                            .padding(.horizontal)
                        } else {
                            Text("Loading...")
                                .onAppear {
                                    if viewModel.upcomingMovie == nil {
                                        viewModel.fetchUpcomingMovie()
                                    }
                                }
                        }

                        // Popular Movies
                        Text("Popular Movies 🍿")
                            .font(.headline)
                            .padding(.horizontal)
                            .foregroundColor(.white)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.popularMovies) { movie in
                                    MovieCard(movie: movie)
                                        .onTapGesture {
                                            selectedMovie = movie
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .sheet(item: $selectedMovie) { movie in
                    MovieDetailView(movie: movie)
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
