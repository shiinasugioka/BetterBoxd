import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var id: String // use ID from auth0
    @Persisted var name: String?
    @Persisted var email: String?
}

class MovieId: Object {
    @Persisted(primaryKey: true) var id: ObjectId
}

class Review: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var user: User? // mark unoptional after auth0 is setup
    @Persisted var movieID: MovieId?
    @Persisted var rating: Int  // out of 5 in 0.5 increments
}

class UserMovieLists: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var user: User? // mark unoptional after auth0 is set up
    @Persisted var favoriteMovies = List<MovieId>()
    @Persisted var moviesToWatch = List<MovieId>()
}

