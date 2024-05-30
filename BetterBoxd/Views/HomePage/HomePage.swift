// Views/HomePage/HomePage.swift
import SwiftUI

struct HomePage: View {
    @ObservedObject var viewModel = MoviesViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                HStack {
                    if let posterURL = movie.posterURL {
                        AsyncImage(url: posterURL) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 75)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.headline)
                        Text(movie.overview)
                            .font(.subheadline)
                            .lineLimit(3)
                    }
                }
            }
            .navigationTitle("Popular Movies")
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
