// Models/Movie.swift
import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?

    var posterURL: URL? {
        if let path = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        }
        return nil
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}

