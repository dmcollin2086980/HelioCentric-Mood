import Foundation
import Data

struct JSONExporter {
    static func exportMoodEntry(_ entry: MoodEntry) -> Data? {
        let exportData = MoodEntryExport(
            id: entry.id,
            createdAt: entry.createdAt,
            emoji: entry.emoji,
            intensity: entry.intensity,
            tags: entry.tags,
            note: entry.note,
            isShared: entry.isShared
        )
        
        return try? JSONEncoder().encode(exportData)
    }
    
    static func exportReflection(_ reflection: Reflection) -> Data? {
        let exportData = ReflectionExport(
            id: reflection.id,
            createdAt: reflection.createdAt,
            text: reflection.text,
            linkedMoodId: reflection.linkedMood?.id,
            isShared: reflection.isShared,
            durationSeconds: reflection.durationSeconds
        )
        
        return try? JSONEncoder().encode(exportData)
    }
    
    static func exportQuote(_ quote: Quote) -> Data? {
        let exportData = QuoteExport(
            id: quote.id,
            text: quote.text,
            author: quote.author,
            category: quote.category,
            isFavorite: quote.isFavorite
        )
        
        return try? JSONEncoder().encode(exportData)
    }
}

// MARK: - Export Models

struct MoodEntryExport: Codable {
    let id: UUID
    let createdAt: Date
    let emoji: String
    let intensity: Int
    let tags: [String]
    let note: String?
    let isShared: Bool
}

struct ReflectionExport: Codable {
    let id: UUID
    let createdAt: Date
    let text: String
    let linkedMoodId: UUID?
    let isShared: Bool
    let durationSeconds: Int?
}

struct QuoteExport: Codable {
    let id: UUID
    let text: String
    let author: String?
    let category: String
    let isFavorite: Bool
}
