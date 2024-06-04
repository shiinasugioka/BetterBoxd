import SwiftUI

struct HomePage: View {
    @Binding var profile: Profile
    @ObservedObject var viewModel = MoviesViewModel()
    @State private var selectedMovie: Movie? = nil
    private var userName: String = "UserName"
    
    init(profile: Binding<Profile>) {
        self._profile = profile
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "darkBlue")
        
        appearance.titleTextAttributes = [.foregroundColor: Color.foregroundWhite.toUIColor()]
        appearance.largeTitleTextAttributes = [.foregroundColor: Color.foregroundWhite.toUIColor()]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

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

//struct HomePage_Previews: PreviewProvider {
//    static var previews: some View {
//        let preview = HomePage_Previews()
//        return Group {
//            HomePage(profile: preview.$profile)
//                .previewDevice("iPhone 12")
//            HomePage()
//                .previewDevice("iPad Pro (12.9-inch) (5th generation)")
//        }
//    }
//}
