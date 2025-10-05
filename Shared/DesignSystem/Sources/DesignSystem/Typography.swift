import SwiftUI

struct AppTypography {
    // Large titles (hero text only)
    static let largeTitle = Font.largeTitle.weight(.bold)
    static let title = Font.title.weight(.semibold)
    static let title2 = Font.title2.weight(.semibold)
    static let title3 = Font.title3.weight(.medium)
    
    // Headlines and subheadlines (primary text)
    static let headline = Font.headline.weight(.medium)
    static let subheadline = Font.subheadline.weight(.regular)
    
    // Body text
    static let body = Font.body.weight(.regular)
    static let bodyEmphasized = Font.body.weight(.medium)
    static let callout = Font.callout.weight(.regular)
    
    // Captions and footnotes
    static let caption = Font.caption.weight(.regular)
    static let caption2 = Font.caption2.weight(.medium)
    static let footnote = Font.footnote.weight(.regular)
}

// Dynamic Type support
extension Font {
    static func appLargeTitle() -> Font {
        .largeTitle.weight(.bold)
    }
    
    static func appTitle() -> Font {
        .title.weight(.semibold)
    }
    
    static func appHeadline() -> Font {
        .headline.weight(.medium)
    }
    
    static func appBody() -> Font {
        .body.weight(.regular)
    }
    
    static func appCaption() -> Font {
        .caption.weight(.regular)
    }
}
