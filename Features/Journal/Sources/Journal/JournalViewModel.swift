import Foundation
import SwiftData
import Core
import Data

@MainActor
final class JournalViewModel: ObservableObject {
    @Published var selectedEmoji: String = ""
    @Published var intensity: Int = 5
    @Published var note: String = ""
    @Published var showSuccessBanner: Bool = false
    
    private let modelContext: ModelContext
    private let logger: Logger
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.logger = Logger(subsystem: "com.helioCentric.mood", category: "JournalViewModel")
    }
    
    func selectEmoji(_ emoji: String) {
        selectedEmoji = emoji
        logger.info("Emoji selected: \(emoji)")
    }
    
    func updateIntensity(_ newIntensity: Int) {
        intensity = newIntensity
        logger.info("Intensity updated to: \(newIntensity)")
    }
    
    func saveMoodEntry() {
        guard !selectedEmoji.isEmpty else {
            logger.warning("Cannot save mood entry: no emoji selected")
            return
        }
        
        let moodEntry = MoodEntry(
            emoji: selectedEmoji,
            intensity: intensity,
            note: note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : note.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        
        modelContext.insert(moodEntry)
        
        do {
            try modelContext.save()
            logger.info("Mood entry saved successfully")
            
            // Reset form
            selectedEmoji = ""
            intensity = 5
            note = ""
            showSuccessBanner = true
            
        } catch {
            logger.error("Failed to save mood entry: \(error)")
        }
    }
}
