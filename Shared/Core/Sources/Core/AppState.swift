import Foundation
import SwiftUI
import os

@MainActor
final class AppState: ObservableObject {
    @Published var currentTab: Tab = .mood
    @Published var isInitialized = false
    
    let hapticsService: HapticsService
    let logger: Logger
    
    init() {
        self.hapticsService = SystemHapticsService()
        self.logger = Logger(subsystem: "com.helioCentric.mood", category: "AppState")
    }
    
    func initialize() {
        logger.info("Initializing app state")
        isInitialized = true
    }
}

enum Tab: String, CaseIterable {
    case mood = "mood"
    case reflect = "reflect"
    case journal = "journal"
    case quotes = "quotes"
    case settings = "settings"
    
    var title: String {
        switch self {
        case .mood: return "Mood"
        case .reflect: return "Reflect"
        case .journal: return "Journal"
        case .quotes: return "Quotes"
        case .settings: return "Settings"
        }
    }
    
    var iconName: String {
        switch self {
        case .mood: return "sun.max"
        case .reflect: return "brain.head.profile"
        case .journal: return "book"
        case .quotes: return "quote.bubble"
        case .settings: return "gearshape"
        }
    }
    
    var accessibilityLabel: String {
        switch self {
        case .mood: return "Mood tracking"
        case .reflect: return "Reflection journal"
        case .journal: return "Mood journal"
        case .quotes: return "Wisdom quotes"
        case .settings: return "App settings"
        }
    }
}
