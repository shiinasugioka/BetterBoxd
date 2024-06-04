import RealmSwift
import Foundation

class RealmManager {
    static let shared = RealmManager()
    let app: RealmSwift.App?
    
    private init() {
        // Configure Realm with migration
        let config = Realm.Configuration(
            schemaVersion: 3, // Update the schema version if you make further changes
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // Existing migration logic for schema version 2
                } else if oldSchemaVersion < 3 {
                    // Migration logic for schema version 3
                    migration.enumerateObjects(ofType: Review.className()) { oldObject, newObject in
                        // Handle the removal of the 'user' property and addition of the 'profile' property
                        // for the 'Review' object
                    }
                    migration.enumerateObjects(ofType: UserMovieLists.className()) { oldObject, newObject in
                        // Handle the removal of the 'user' property and addition of the 'profile' property
                        // for the 'UserMovieLists' object
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

  
}
