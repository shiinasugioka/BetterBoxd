import RealmSwift
import Foundation

class RealmManager {
    static let shared = RealmManager()
    let app: RealmSwift.App?
    
    private init() {
        // Configure Realm with migration
        let config = Realm.Configuration(
            schemaVersion: 2, // Update the schema version if you make further changes
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // Migrate from MovieId to Int for movieID in Review
                    migration.enumerateObjects(ofType: Review.className()) { oldObject, newObject in
                        // Provide a default value for the new movieID field
                        newObject?["movieID"] = 0
                    }
                }
            }
        )
        
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
        print("Realm is located at:", realm.configuration.fileURL!)
        
        let appId = Bundle.main.object(forInfoDictionaryKey: "REALM_APP_ID") as! String
        self.app = RealmSwift.App(id: appId)
    }
    
    func getConfiguration() -> Realm.Configuration {
        return Realm.Configuration()
    }

    func addUser(name: String, email: String) {
        let user = User()
        user.name = name
        user.email = email
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
        }
        
        print("User added successfully")
    }
}
