import SwiftUI

struct HomePage: View {
    @Binding var profile: Profile
    @ObservedObject var viewModel = MoviesViewModel()
    @State var selectedMovie: Movie? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBlue.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Welcome, \($profile.username)!")
                            .font(.title)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        
                        
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
                        // Your Favorite Movies
                        Text("Your Favorite Movies ❤️")
                            .font(.headline)
                            .padding(.horizontal)
                            .foregroundColor(.white)

                        if !viewModel.favoriteMovies.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.favoriteMovies) { movie in
                                        MovieCard(movie: movie)
                                            .onTapGesture {
                                                selectedMovie = movie
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("Watch some films first!")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }

                        // Movies on Your Watchlist
                        Text("Movies on Your Watchlist 📝")
                            .font(.headline)
                            .padding(.horizontal)
                            .foregroundColor(.white)

                        if !viewModel.watchlistMovies.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.watchlistMovies) { movie in
                                        MovieCard(movie: movie)
                                            .onTapGesture {
                                                selectedMovie = movie
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("Watch some films first!")
                                .foregroundColor(.white)
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
