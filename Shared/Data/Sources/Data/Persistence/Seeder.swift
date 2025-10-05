import Foundation
import SwiftData

final class Seeder {
    static func seedData(into container: ModelContainer) async {
        let context = container.mainContext
        
        // Check if data already exists
        let quoteDescriptor = FetchDescriptor<Quote>()
        let existingQuotes = try? context.fetch(quoteDescriptor)
        
        if let existingQuotes = existingQuotes, !existingQuotes.isEmpty {
            return // Data already seeded
        }
        
        // Seed quotes
        let quotes = createSampleQuotes()
        for quote in quotes {
            context.insert(quote)
        }
        
        // Seed sample mood entry
        let sampleMood = MoodEntry(
            emoji: "😊",
            intensity: 7,
            tags: ["happy", "productive"],
            note: "Feeling great after a good workout!"
        )
        context.insert(sampleMood)
        
        // Seed sample reflection
        let sampleReflection = Reflection(
            text: "Today I practiced mindfulness during my morning walk. The fresh air and quiet moments helped me feel more centered and ready for the day ahead.",
            linkedMood: sampleMood,
            durationSeconds: 480 // 8 minutes
        )
        context.insert(sampleReflection)
        
        // Seed default settings
        let defaultSettings = UserSettings()
        context.insert(defaultSettings)
        
        do {
            try context.save()
        } catch {
            print("Failed to seed data: \(error)")
        }
    }
    
    private static func createSampleQuotes() -> [Quote] {
        [
            Quote(text: "Wisdom begins in wonder.", author: "Socrates", category: "Wisdom"),
            Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs", category: "Action"),
            Quote(text: "Happiness is not something ready made. It comes from your own actions.", author: "Dalai Lama", category: "Happiness"),
            Quote(text: "You have power over your mind - not outside events. Realize this, and you will find strength.", author: "Marcus Aurelius", category: "Control"),
            Quote(text: "The best revenge is to be unlike him who performed the injury.", author: "Marcus Aurelius", category: "Revenge"),
            Quote(text: "Fear is the mind-killer.", author: "Frank Herbert", category: "Fear"),
            Quote(text: "Freedom is nothing else but a chance to be better.", author: "Albert Camus", category: "Freedom"),
            Quote(text: "Life is what happens to you while you're busy making other plans.", author: "John Lennon", category: "Life"),
            Quote(text: "We are what we repeatedly do. Excellence, then, is not an act, but a habit.", author: "Aristotle", category: "Action"),
            Quote(text: "The mind is everything. What you think you become.", author: "Buddha", category: "Perception"),
            Quote(text: "Anger is an acid that can do more harm to the vessel in which it is stored than to anything on which it is poured.", author: "Mark Twain", category: "Anger"),
            Quote(text: "The unexamined life is not worth living.", author: "Socrates", category: "Wisdom")
        ]
    }
}
