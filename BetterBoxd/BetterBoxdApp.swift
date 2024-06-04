
import SwiftUI
import RealmSwift

@main
struct BetterBoxdApp: SwiftUI.App {
    init() {
        _ = RealmManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
        AuthStarterView()
//             MainView()
//                 .environment(\.realmConfiguration, RealmManager.shared.getConfiguration())
        }
    }
}
