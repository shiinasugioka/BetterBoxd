import Foundation

struct Profile: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let picture: URL?
}
