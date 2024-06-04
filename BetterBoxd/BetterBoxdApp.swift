import SwiftUI

@main
struct BetterBoxdApp: SwiftUI.App {
    init() {
        _ = RealmManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            AuthStarterView()
                .environmentObject(AuthController()) // Pass the AuthController environment object
        }
    }
}
