import Foundation
import SwiftData
import Core
import Data

@MainActor
final class MoodViewModel: ObservableObject {
    @Published var dailyQuote: Quote?
    @Published var todaysReflection: Reflection?
    @Published var shortcuts: [ShortcutChip] = []
    
    private let modelContext: ModelContext
    private let logger: Logger
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.logger = Logger(subsystem: "com.helioCentric.mood", category: "MoodViewModel")
    }
    
    func loadData() {
        loadDailyQuote()
        loadTodaysReflection()
        loadShortcuts()
    }
    
    private func loadDailyQuote() {
        let descriptor = FetchDescriptor<Quote>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        do {
            let quotes = try modelContext.fetch(descriptor)
            dailyQuote = quotes.first
        } catch {
            logger.error("Failed to load daily quote: \(error)")
        }
    }
    
    private func loadTodaysReflection() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        let descriptor = FetchDescriptor<Reflection>(
            predicate: #Predicate<Reflection> { reflection in
                reflection.createdAt >= today && reflection.createdAt < tomorrow
            },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        do {
            let reflections = try modelContext.fetch(descriptor)
            todaysReflection = reflections.first
        } catch {
            logger.error("Failed to load today's reflection: \(error)")
        }
    }
    
    private func loadShortcuts() {
        shortcuts = [
            ShortcutChip(id: "energy", title: "Energy", icon: "bolt.fill"),
            ShortcutChip(id: "week", title: "Week", icon: "calendar"),
            ShortcutChip(id: "journal", title: "Journal", icon: "book"),
            ShortcutChip(id: "reflect", title: "Reflect", icon: "brain.head.profile"),
            ShortcutChip(id: "7days", title: "7 Days", icon: "chart.line.uptrend.xyaxis"),
            ShortcutChip(id: "cosmos", title: "Cosmos", icon: "sparkles"),
            ShortcutChip(id: "wisdom", title: "Wisdom", icon: "lightbulb"),
            ShortcutChip(id: "earth", title: "Earth", icon: "globe"),
            ShortcutChip(id: "yesterday", title: "Yesterday", icon: "clock.arrow.circlepath"),
            ShortcutChip(id: "insights", title: "Insights", icon: "chart.bar"),
            ShortcutChip(id: "centered", title: "Centered", icon: "target")
        ]
    }
    
    func handleShortcutTap(_ shortcut: ShortcutChip) {
        logger.info("Shortcut tapped: \(shortcut.id)")
        // TODO: Implement navigation or actions for each shortcut
    }
}

struct ShortcutChip: Identifiable {
    let id: String
    let title: String
    let icon: String
}
