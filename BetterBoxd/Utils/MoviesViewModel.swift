import Foundation

class MoviesViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var searchedMovies: [Movie] = []
    @Published var autocompleteResults: [Movie] = []
    
    private let apiKey: String
    private let token: String?

    init() {
        // Fetch API Key from info.plist
        if let key = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String {
            apiKey = key
        } else {
            apiKey = ""
            print("Error: TMDB_API_KEY not found in info.plist")
        }
        
        // Fetch Token from info.plist (optional)
        if let tokenValue = Bundle.main.infoDictionary?["TMDB_API_TOKEN"] as? String {
            token = tokenValue
        } else {
            token = ""
            print("Error: TMDB_API_TOKEN not found in info.plist")
        }
        
        fetchPopularMovies()
    }

    func fetchPopularMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular") else {
            print("Error: Invalid URL")
            return
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        components.queryItems = queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Set the Authorization header only if the token is available
        if let token = token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        // Print the request details for debugging
        print("Request URL: \(request.url?.absoluteString ?? "Invalid URL")")
        print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching popular movies: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: No data received")
                return
            }

            do {
                // Print the JSON response for debugging
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: \(jsonString)")
                }
                
                let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    self.popularMovies = decodedResponse.results
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }

    func searchMovies(query: String) {
        guard !query.isEmpty else {
            return
        }
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie") else {
            print("Error: Invalid URL")
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Set the Authorization header only if the token is available
        if let token = token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Print the request details for debugging
        print("Request URL: \(request.url?.absoluteString ?? "Invalid URL")")
        print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                // Print the JSON response for debugging
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: \(jsonString)")
                }
                
                let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    self.searchedMovies = decodedResponse.results
                    self.autocompleteResults = Array(decodedResponse.results.prefix(3))
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
}
