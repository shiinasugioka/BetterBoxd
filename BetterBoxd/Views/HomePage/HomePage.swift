import SwiftUI

struct HomePage: View {
    @ObservedObject var viewModel = MoviesViewModel()
    @State private var selectedMovie: Movie? = nil
    private var userName: String = "UserName"

    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBlue.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Welcome, \(userName)!")
                            .font(.title)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        // Upcoming Movies
                        Text("Upcoming Movies 🎬")
                            .font(.headline)
                            .padding(.horizontal)
                            .foregroundColor(.white)

                        if !viewModel.filteredUpcomingMovies.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.filteredUpcomingMovies) { movie in
                                        CountdownCard(movie: movie, releaseDate: movie.releaseDate ?? Date())
                                            .onTapGesture {
                                                selectedMovie = movie
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("Loading...")
                                .foregroundColor(.white)
                                .padding()
                                .onAppear {
                                    if viewModel.filteredUpcomingMovies.isEmpty {
                                        viewModel.fetchUpcomingMovie()
                                    }
                                }
                        }
                        
//                        Text("Upcoming Movies 🍿")
//                            .font(.headline)
//                            .padding(.horizontal)
//                            .foregroundColor(.white)
//                        // Upcoming Movie
//                        if let upcomingMovie = viewModel.upcomingMovie {
//                            CountdownCard(movie: upcomingMovie, releaseDate: upcomingMovie.releaseDate ?? Date())
//                                .padding(.horizontal)
//                                .onTapGesture {
//                                    selectedMovie = upcomingMovie
//                                }
//                        } else {
//                            Text("Loading...")
//                                .foregroundColor(.white)
//                                .padding()
//                                .onAppear {
//                                    if viewModel.upcomingMovie == nil {
//                                        viewModel.fetchUpcomingMovie()
//                                    }
//                                }
//                        }

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
