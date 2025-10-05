import SwiftUI
import SwiftData
import Core
import Data

@main
struct HelioCentricMoodApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView()
                .environmentObject(appState)
                .modelContainer(ModelContainerFactory.shared.container)
        }
    }
}
