import Foundation
import SwiftData
import CloudKit

final class ModelContainerFactory {
    static let shared = ModelContainerFactory()
    
    private init() {}
    
    lazy var container: ModelContainer = {
        let schema = Schema([
            MoodEntry.self,
            Reflection.self,
            Quote.self,
            UserSettings.self
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            cloudKitDatabase: .private("iCloud.com.helioCentric.mood")
        )
        
        do {
            let container = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            return container
        } catch {
            // Fallback to local-only configuration if CloudKit fails
            let localConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )
            
            do {
                let container = try ModelContainer(
                    for: schema,
                    configurations: [localConfiguration]
                )
                return container
            } catch {
                fatalError("Failed to create ModelContainer: \(error)")
            }
        }
    }()
    
    func createLocalContainer() -> ModelContainer {
        let schema = Schema([
            MoodEntry.self,
            Reflection.self,
            Quote.self,
            UserSettings.self
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        
        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Failed to create local ModelContainer: \(error)")
        }
    }
}
