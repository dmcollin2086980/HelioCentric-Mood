import Foundation
import SwiftData
import Core
import Data

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var settings: UserSettings = UserSettings()
    
    private let modelContext: ModelContext
    private let logger: Logger
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.logger = Logger(subsystem: "com.helioCentric.mood", category: "SettingsViewModel")
    }
    
    func loadSettings() {
        let descriptor = FetchDescriptor<UserSettings>()
        
        do {
            let settingsArray = try modelContext.fetch(descriptor)
            if let existingSettings = settingsArray.first {
                settings = existingSettings
            } else {
                // Create default settings if none exist
                modelContext.insert(settings)
                try modelContext.save()
            }
        } catch {
            logger.error("Failed to load settings: \(error)")
        }
    }
    
    func updateTheme(_ newTheme: String) {
        settings.theme = newTheme
        saveSettings()
        logger.info("Theme updated to: \(newTheme)")
    }
    
    func toggleHaptics() {
        settings.hapticsEnabled.toggle()
        saveSettings()
        logger.info("Haptics toggled: \(settings.hapticsEnabled)")
    }
    
    func toggleDarkMode() {
        settings.darkModeEnabled.toggle()
        saveSettings()
        logger.info("Dark mode toggled: \(settings.darkModeEnabled)")
    }
    
    func toggleiCloudSync() {
        settings.iCloudSyncEnabled.toggle()
        saveSettings()
        logger.info("iCloud sync toggled: \(settings.iCloudSyncEnabled)")
    }
    
    func togglePrivacyLock() {
        settings.privacyLockEnabled.toggle()
        saveSettings()
        logger.info("Privacy lock toggled: \(settings.privacyLockEnabled)")
    }
    
    private func saveSettings() {
        do {
            try modelContext.save()
        } catch {
            logger.error("Failed to save settings: \(error)")
        }
    }
}
