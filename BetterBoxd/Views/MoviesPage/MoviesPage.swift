import SwiftUI

struct MoviesPage: View {
    @State private var searchText: String = ""
    @State private var selectedMovie: Movie? = nil
    @Binding var profile: Profile
    @ObservedObject private var viewModel: MoviesViewModel
    
    init(profile: Binding<Profile>) {
        self._profile = profile
        self.viewModel = MoviesViewModel(userId: profile.wrappedValue.id)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "darkBlue")
        
        appearance.titleTextAttributes = [.foregroundColor: Color.foregroundWhite.toUIColor()]
        appearance.largeTitleTextAttributes = [.foregroundColor: Color.foregroundWhite.toUIColor()]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
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
                            .foregroundColor(.foregroundWhite)
                        
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
                        
                        Text("Movie highlight of the day 🕒")
                            .font(.headline)
                            .padding(.horizontal)
                            .foregroundColor(.white)

                        MovieHighlightCard(movie: viewModel.popularMovies.first ?? Movie(id: 3, title: "Shutter Island", overview: "In 1954, a U.S. Marshal investigates the disappearance of a murderer, who escaped from a hospital for the criminally insane.", posterPath: "/52d8Y2aE2xUJd7Qkq6Yv0UMu3fh.jpg", releaseDate: nil))
                            .padding(.horizontal)
                            .onTapGesture {
                                selectedMovie = viewModel.popularMovies.first
                             }

                        // Popular Movies
                        Text("Popular Movies 🍿")
                            .font(.headline)
                            .padding(.horizontal)
                            .foregroundColor(.foregroundWhite)
                        
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
                    MovieDetailView(movie: movie, userId: $profile.wrappedValue.id)
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
                            .cornerRadius(13)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Color.gray
                        .frame(width: 100, height: 150)
                        .cornerRadius(13)
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
        .background(
            ZStack {
                VisualEffectBlur()
                Color.white.opacity(0.2)
            }
        )
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.salmonPink,
                            Color.darkBlue,
                            Color.lightBlue,
                            Color.pastelYellow,
                            Color.foregroundWhite
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 4
                )
        )
    }
}

//struct SearchPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesPage()
//    }
//}
//
//struct MoviesPage_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesPage()
//            .previewDevice("iPhone 12")
//        MoviesPage()
//            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
//    }
//}
