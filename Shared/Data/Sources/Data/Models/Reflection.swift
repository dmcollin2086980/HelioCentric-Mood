import Foundation
import SwiftData

@Model
final class Reflection {
    @Attribute(.unique) var id: UUID
    var createdAt: Date
    var text: String
    var linkedMood: MoodEntry?
    var isShared: Bool
    var durationSeconds: Int?
    
    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        text: String,
        linkedMood: MoodEntry? = nil,
        isShared: Bool = false,
        durationSeconds: Int? = nil
    ) {
        self.id = id
        self.createdAt = createdAt
        self.text = text
        self.linkedMood = linkedMood
        self.isShared = isShared
        self.durationSeconds = durationSeconds
    }
}

extension Reflection {
    var durationFormatted: String? {
        guard let durationSeconds = durationSeconds else { return nil }
        
        let minutes = durationSeconds / 60
        let seconds = durationSeconds % 60
        
        if minutes > 0 {
            return "\(minutes) min, \(seconds) sec"
        } else {
            return "\(seconds) sec"
        }
    }
    
    var previewText: String {
        let maxLength = 100
        if text.count <= maxLength {
            return text
        } else {
            let index = text.index(text.startIndex, offsetBy: maxLength)
            return String(text[..<index]) + "..."
        }
    }
}
