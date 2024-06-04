import SwiftUI

struct MoviesPage: View {
    @State private var searchText: String = ""
    @State private var selectedMovie: Movie? = nil
    @ObservedObject private var viewModel: MoviesViewModel = MoviesViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBlue.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Search Bar
                        HStack {
                            TextField("Look for a movie 🎬", text: $searchText, onEditingChanged: { _ in
                                viewModel.searchMovies(query: searchText)
                            })
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            
                            Button(action: {
                                viewModel.searchMovies(query: searchText)
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Autocomplete Results
                        if !viewModel.autocompleteResults.isEmpty {
                            VStack(alignment: .leading) {
                                ForEach(viewModel.autocompleteResults) { movie in
                                    Text(movie.title)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            searchText = movie.title
                                            viewModel.searchMovies(query: movie.title)
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Recently Searched
                        Text("Recently searched ✈️")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.searchedMovies) { movie in
                                    MovieCard(movie: movie)
                                        .onTapGesture {
                                            selectedMovie = movie
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Movie Highlight of the Day
                        Text("Movie highlight of the day 🕒")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        MovieHighlightCard(movie: viewModel.popularMovies.first ?? Movie(id: 3, title: "Shutter Island", overview: "In 1954, a U.S. Marshal investigates the disappearance of a murderer, who escaped from a hospital for the criminally insane.", posterPath: "/52d8Y2aE2xUJd7Qkq6Yv0UMu3fh.jpg"))
                            .padding(.horizontal)
                        
                        // Popular Movies
                        Text("Popular Movies 🍿")
                            .font(.headline)
                            .padding(.horizontal)
                        
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
                //            .navigationTitle("Search Movies")
                .sheet(item: $selectedMovie) { movie in
                    MovieDetailView(movie: movie)
                }
            }
        }
    }
}
struct MovieCard: View {
    let movie: Movie

    var body: some View {
    ZStack {
    Color.darkBlue.edgesIgnoringSafeArea(.all)

        VStack {
            if let url = movie.posterURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Color.gray
                    .frame(width: 100, height: 150)
                    .cornerRadius(10)
            }
        }
    }
    }
}

struct MovieHighlightCard: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let url = movie.posterURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 150)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Color.gray
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title3)
                        .bold()

                    Text(movie.overview)
                        .font(.body)
                        .lineLimit(6)
                        .padding(.top, 4)
                }
                .padding(.leading, 10)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesPage()
    }
}
