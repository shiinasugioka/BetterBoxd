//
//  Profile.swift
//  BetterBoxd
//
//  Created by Ahmed Ghaddah on 6/3/24.
//

import Foundation
import JWTDecode

struct Profile: Codable, Identifiable {
    let id: String
    var name: String
    var username: String
    var bio: String
    let email: String
    let emailVerified: Bool
    var picture: String
    var updatedAt: String
    var isPrivate: Bool
    
    static var empty: Self {
        return Profile(
            id: "",
            name: "",
            username: "",
            bio: "",
            email: "",
            emailVerified: false,
            picture: "",
            updatedAt: "",
            isPrivate: false
        )
    }
    
    static func from(_ idToken: String) -> Self {
        
        //if you are sucessful decoding the information than we can move forward
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
        
        
        //after getting the auth creating the first profile data.
        //updates to username bio and privacy setting will be set up later and will be in settings
        return Profile(
            id: id, name: name, username: "", bio: "", email: email, emailVerified:emailVerified , picture: picture, updatedAt: updatedAt, isPrivate: false
        )

    }
}
