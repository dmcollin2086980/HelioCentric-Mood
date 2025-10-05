import Foundation
import Data

struct MarkdownExporter {
    static func exportMoodEntry(_ entry: MoodEntry) -> String {
        var markdown = "# Mood Entry\n\n"
        markdown += "**Date:** \(entry.createdAt.formatted(date: .abbreviated, time: .shortened))\n"
        markdown += "**Mood:** \(entry.emoji)\n"
        markdown += "**Intensity:** \(entry.intensity)/10 (\(entry.intensityDescription))\n"
        
        if !entry.tags.isEmpty {
            markdown += "**Tags:** \(entry.tags.joined(separator: ", "))\n"
        }
        
        if let note = entry.note, !note.isEmpty {
            markdown += "\n## Notes\n\n\(note)\n"
        }
        
        return markdown
    }
    
    static func exportReflection(_ reflection: Reflection) -> String {
        var markdown = "# Reflection\n\n"
        markdown += "**Date:** \(reflection.createdAt.formatted(date: .abbreviated, time: .shortened))\n"
        
        if let duration = reflection.durationFormatted {
            markdown += "**Duration:** \(duration)\n"
        }
        
        markdown += "\n## Content\n\n\(reflection.text)\n"
        
        if let linkedMood = reflection.linkedMood {
            markdown += "\n## Linked Mood\n\n"
            markdown += "**Mood:** \(linkedMood.emoji)\n"
            markdown += "**Intensity:** \(linkedMood.intensity)/10\n"
            
            if let note = linkedMood.note {
                markdown += "**Note:** \(note)\n"
            }
        }
        
        return markdown
    }
    
    static func exportQuote(_ quote: Quote) -> String {
        var markdown = "# Quote\n\n"
        markdown += "> \(quote.text)\n\n"
        markdown += "— \(quote.displayAuthor)\n\n"
        markdown += "**Category:** \(quote.categoryDisplayName)\n"
        
        if quote.isFavorite {
            markdown += "**Favorite:** ⭐\n"
        }
        
        return markdown
    }
}
