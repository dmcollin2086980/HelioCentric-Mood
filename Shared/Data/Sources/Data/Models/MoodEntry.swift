import Foundation
import SwiftData

@Model
final class MoodEntry {
    @Attribute(.unique) var id: UUID
    var createdAt: Date
    var emoji: String
    var intensity: Int
    var tags: [String]
    var note: String?
    var isShared: Bool
    
    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        emoji: String,
        intensity: Int,
        tags: [String] = [],
        note: String? = nil,
        isShared: Bool = false
    ) {
        self.id = id
        self.createdAt = createdAt
        self.emoji = emoji
        self.intensity = intensity
        self.tags = tags
        self.note = note
        self.isShared = isShared
    }
}

extension MoodEntry {
    var intensityDescription: String {
        switch intensity {
        case 0...2: return "Very Low"
        case 3...4: return "Low"
        case 5...6: return "Moderate"
        case 7...8: return "High"
        case 9...10: return "Very High"
        default: return "Unknown"
        }
    }
}
