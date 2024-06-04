//
//  Profile.swift
//  BetterBoxd
//
//  Created by Ahmed Ghaddah on 6/3/24.
//

import Foundation
import JWTDecode
import RealmSwift

class Profile: Object, Identifiable, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var bio: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var emailVerified: Bool = false
    @objc dynamic var picture: String = ""
    @objc dynamic var updatedAt: String = ""
    @objc dynamic var isPrivate: Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }

    static var empty: Profile {
        return Profile()
    }

    func updateUserProfileInRealm(userProfile: Profile) {
        let realm = try! Realm() // Get the default Realm
        try! realm.write {
            if let existingUser = realm.object(ofType: Profile.self, forPrimaryKey: userProfile.id) {
                // Update existing user
                existingUser.name = userProfile.name
                existingUser.username = userProfile.username
                existingUser.bio = userProfile.bio
                existingUser.email = userProfile.email
                existingUser.emailVerified = userProfile.emailVerified
                existingUser.picture = userProfile.picture
                existingUser.updatedAt = userProfile.updatedAt
                existingUser.isPrivate = userProfile.isPrivate
            } else {
                // Add new user
                realm.add(userProfile)
            }
        }
    }

    static func from(_ idToken: String) -> Profile {
        guard
            let jwt = try? decode(jwt: idToken),
            let id = jwt.subject,
            let name = jwt.claim(name: "name").string,
            let email = jwt.claim(name: "email").string,
            let emailVerified = jwt.claim(name: "email_verified").boolean,
            let picture = jwt.claim(name: "picture").string,
            let updatedAt = jwt.claim(name: "updated_at").string
        else {
            return .empty
        }

        let profile = Profile()
        profile.id = id
        profile.name = name
        profile.username = ""
        profile.bio = ""
        profile.email = email
        profile.emailVerified = emailVerified
        profile.picture = picture
        profile.updatedAt = updatedAt
        profile.isPrivate = false
        return profile
    }

    // Make Profile conform to Codable
    enum CodingKeys: String, CodingKey {
        case id, name, username, bio, email, emailVerified, picture, updatedAt, isPrivate
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        bio = try container.decode(String.self, forKey: .bio)
        email = try container.decode(String.self, forKey: .email)
        emailVerified = try container.decode(Bool.self, forKey: .emailVerified)
        picture = try container.decode(String.self, forKey: .picture)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        isPrivate = try container.decode(Bool.self, forKey: .isPrivate)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
        try container.encode(bio, forKey: .bio)
        try container.encode(email, forKey: .email)
        try container.encode(emailVerified, forKey: .emailVerified)
        try container.encode(picture, forKey: .picture)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(isPrivate, forKey: .isPrivate)
    }
    // Fetch user profile from Realm
    static func fetchUserProfileFromRealm(withId id: String) -> Profile? {
        let realm = try! Realm() // Get the default Realm
        return realm.object(ofType: Profile.self, forPrimaryKey: id)
    }
}
