import Foundation
import Combine
import RealmSwift

class MoviesViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var searchedMovies: [Movie] = []
    @Published var autocompleteResults: [Movie] = []
    @Published var upcomingMovie: Movie?
    @Published var filteredUpcomingMovies: [Movie] = []
    @Published var reviewedMovies: [Movie] = []
    @Published var favoriteMovies: [Movie] = []
    @Published var watchlistMovies: [Movie] = []
    private var cancellables = Set<AnyCancellable>()
    private let apiKey: String
    private let token: String?
    private let userId: String
    
    init(userId: String) {
        // Initialize user ID
        self.userId = userId
        
        
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
        fetchUpcomingMovie()
        fetchReviewedMovies(for: userId)
    }
    
    func fetchReviewedMovies(for userId: String) {
        let realm = try! Realm()
        let reviews = realm.objects(Review.self).filter("user.id == %@", userId)
        
        let movieIds: [Int] = Array(reviews.compactMap { $0.movieID })
        print("bruh")
        print("Movie IDs from reviews: \(movieIds)")
        
        if !movieIds.isEmpty {
            fetchMovies(by: movieIds)
            print("test2")
            print(movieIds)
        }
    }
    
    private func fetchMovies(by ids: [Int]) {
        guard !ids.isEmpty else {
            self.reviewedMovies = []
            return
        }
        
        let realm = try! Realm()
        let movies = realm.objects(Movie.self).filter("id IN %@", ids)
        
        self.reviewedMovies = Array(movies)
        
        print("Reviewed Movies: \(self.reviewedMovies.map { $0.title })")
    }
    
    func fetchUpcomingMovie() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming") else {
            print("Invalid URL")
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
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: MovieResponse.self, decoder: {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                return decoder
            }())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching upcoming movies: \(error.localizedDescription)")
                }
            }, receiveValue: { response in
                let now = Date()
                let calendar = Calendar.current
                let sevenDaysFromNow = calendar.date(byAdding: .day, value: 7, to: now)!
                let threeWeeksFromNow = calendar.date(byAdding: .weekOfYear, value: 3, to: now)!
                
                self.filteredUpcomingMovies = response.results.filter { movie in
                    guard let releaseDate = movie.releaseDate else { return false }
                    return releaseDate > sevenDaysFromNow && releaseDate <= threeWeeksFromNow
                }
            })
            .store(in: &self.cancellables)
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
        
        if let token = token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
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
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
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
        
        if let token = token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
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
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: \(jsonString)")
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
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

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
