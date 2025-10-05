import Foundation
import SwiftData

@Model
final class UserSettings {
    @Attribute(.unique) var id: UUID
    var theme: String
    var hapticsEnabled: Bool
    var darkModeEnabled: Bool
    var iCloudSyncEnabled: Bool
    var privacyLockEnabled: Bool
    
    init(
        id: UUID = UUID(),
        theme: String = "Earth",
        hapticsEnabled: Bool = true,
        darkModeEnabled: Bool = false,
        iCloudSyncEnabled: Bool = false,
        privacyLockEnabled: Bool = false
    ) {
        self.id = id
        self.theme = theme
        self.hapticsEnabled = hapticsEnabled
        self.darkModeEnabled = darkModeEnabled
        self.iCloudSyncEnabled = iCloudSyncEnabled
        self.privacyLockEnabled = privacyLockEnabled
    }
}

extension UserSettings {
    var currentTheme: AppTheme {
        AppTheme(rawValue: theme) ?? .earth
    }
}

enum AppTheme: String, CaseIterable {
    case earth = "Earth"
    case system = "System"
    case light = "Light"
    case dark = "Dark"
    
    var displayName: String {
        rawValue
    }
}
