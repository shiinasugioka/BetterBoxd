// import Foundation
// import RealmSwift
//
// struct Movie: Identifiable, Codable {
//     let id: Int
//     let title: String
//     let overview: String
//     let posterPath: String?
//     let releaseDate: Date?
//     let adult: Bool
//     let backdropPath: String?
//     let genreIds: [Int]
//     let originalLanguage: String
//     let originalTitle: String
//     let popularity: Double
//     let video: Bool
//     let voteAverage: Double
//     let voteCount: Int
//
//     init(
//         id: Int,
//         title: String,
//         overview: String,
//         posterPath: String? = nil,
//         releaseDate: Date? = nil,
//         adult: Bool = false,
//         backdropPath: String? = nil,
//         genreIds: [Int] = [],
//         originalLanguage: String = "en",
//         originalTitle: String = "",
//         popularity: Double = 0.0,
//         video: Bool = false,
//         voteAverage: Double = 0.0,
//         voteCount: Int = 0
//     ) {
//         self.id = id
//         self.title = title
//         self.overview = overview
//         self.posterPath = posterPath
//         self.releaseDate = releaseDate
//         self.adult = adult
//         self.backdropPath = backdropPath
//         self.genreIds = genreIds
//         self.originalLanguage = originalLanguage
//         self.originalTitle = originalTitle
//         self.popularity = popularity
//         self.video = video
//         self.voteAverage = voteAverage
//         self.voteCount = voteCount
//     }
//
//     var posterURL: URL? {
//         if let path = posterPath {
//             return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
//         }
//         return nil
//     }
//
//     enum CodingKeys: String, CodingKey {
//         case id
//         case title
//         case overview
//         case posterPath = "poster_path"
//         case releaseDate = "release_date"
//         case adult
//         case backdropPath = "backdrop_path"
//         case genreIds = "genre_ids"
//         case originalLanguage = "original_language"
//         case originalTitle = "original_title"
//         case popularity
//         case video
//         case voteAverage = "vote_average"
//         case voteCount = "vote_count"
//     }
// }
//
// struct MovieResponse: Codable {
//     let dates: Dates?
//     let page: Int
//     let results: [Movie]
//     let totalPages: Int
//     let totalResults: Int
//    
//     enum CodingKeys: String, CodingKey {
//         case dates
//         case page
//         case results
//         case totalPages = "total_pages"
//         case totalResults = "total_results"
//     }
// }
//
// struct Dates: Codable {
//     let maximum: String
//     let minimum: String
// }

import Foundation
import RealmSwift

class Movie: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String = ""
    @Persisted var overview: String = ""
    @Persisted var posterPath: String? = nil
    @Persisted var releaseDate: Date? = nil
    @Persisted var adult: Bool = false
    @Persisted var backdropPath: String? = nil
    @Persisted var genreIds = List<Int>()
    @Persisted var originalLanguage: String = "en"
    @Persisted var originalTitle: String = ""
    @Persisted var popularity: Double = 0.0
    @Persisted var video: Bool = false
    @Persisted var voteAverage: Double = 0.0
    @Persisted var voteCount: Int = 0

    override init() {
        super.init()
    }

    init(
        id: Int,
        title: String,
        overview: String,
        posterPath: String? = nil,
        releaseDate: Date? = nil,
        adult: Bool = false,
        backdropPath: String? = nil,
        genreIds: [Int] = [],
        originalLanguage: String = "en",
        originalTitle: String = "",
        popularity: Double = 0.0,
        video: Bool = false,
        voteAverage: Double = 0.0,
        voteCount: Int = 0
    ) {
        super.init()
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds.append(objectsIn: genreIds)
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.popularity = popularity
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }

    var posterURL: URL? {
        if let path = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
 struct MovieResponse: Codable {
     let dates: Dates?
     let page: Int
     let results: [Movie]
     let totalPages: Int
     let totalResults: Int

     enum CodingKeys: String, CodingKey {
         case dates
         case page
         case results
         case totalPages = "total_pages"
         case totalResults = "total_results"
     }
 }

 struct Dates: Codable {
     let maximum: String
     let minimum: String
 }
