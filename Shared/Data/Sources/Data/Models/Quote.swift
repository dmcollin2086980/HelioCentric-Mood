import Foundation
import SwiftData

@Model
final class Quote {
    @Attribute(.unique) var id: UUID
    var text: String
    var author: String?
    var category: String
    var isFavorite: Bool
    
    init(
        id: UUID = UUID(),
        text: String,
        author: String? = nil,
        category: String,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.text = text
        self.author = author
        self.category = category
        self.isFavorite = isFavorite
    }
}

extension Quote {
    var displayAuthor: String {
        author ?? "Unknown"
    }
    
    var categoryDisplayName: String {
        category.capitalized
    }
}

enum QuoteCategory: String, CaseIterable {
    case action = "Action"
    case anger = "Anger"
    case control = "Control"
    case fear = "Fear"
    case freedom = "Freedom"
    case happiness = "Happiness"
    case life = "Life"
    case perception = "Perception"
    case revenge = "Revenge"
    case wisdom = "Wisdom"
    
    var displayName: String {
        rawValue
    }
}
