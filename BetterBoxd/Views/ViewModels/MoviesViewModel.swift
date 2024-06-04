// // ViewModels/MoviesViewModel.swift
// import Foundation

// class MoviesViewModel: ObservableObject {
//     @Published var movies: [Movie] = []

//     private let apiKey = "853c6a41afe7375e78ef84c05c1a6aac"
//     private let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NTNjNmE0MWFmZTczNzVlNzhlZjg0YzA1YzFhNmFhYyIsInN1YiI6IjY2NGI3NDkxY2Q4NGQ4YjRiZjg5Y2M1ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VViCD-cv-jBBEnD7mGyt5sIuaBlCU3YooX-0D-mmAZE"
    
//     init() {
//         fetchPopularMovies()
//     }

//     func fetchPopularMovies() {
//         guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else { return }

//         var request = URLRequest(url: url)
//         request.httpMethod = "GET"
//         request.timeoutInterval = 10
//         request.setValue("application/json", forHTTPHeaderField: "accept")
//         request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

//         URLSession.shared.dataTask(with: request) { (data, response, error) in
//             if let data = data {
//                 do {
//                     let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
//                     DispatchQueue.main.async {
//                         self.movies = decodedResponse.results
//                     }
//                 } catch {
//                     print("Error decoding response: \(error)")
//                 }
//             }
//         }.resume()
//     }
// }

