import SwiftUI

struct Card<Content: View>: View {
    let content: Content
    let style: CardStyle
    
    init(style: CardStyle = .default, @ViewBuilder content: () -> Content) {
        self.style = style
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(style.padding)
            .background(style.background)
            .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius))
            .shadow(
                color: style.shadowColor,
                radius: style.shadowRadius,
                x: style.shadowOffset.x,
                y: style.shadowOffset.y
            )
    }
}

struct CardStyle {
    let padding: CGFloat
    let background: AnyView
    let cornerRadius: CGFloat
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowOffset: CGSize
    
    static let `default` = CardStyle(
        padding: 16,
        background: AnyView(Color.white),
        cornerRadius: 16,
        shadowColor: EarthTheme.cardShadow,
        shadowRadius: 8,
        shadowOffset: CGSize(width: 0, height: 4)
    )
    
    static let subtle = CardStyle(
        padding: 12,
        background: AnyView(Color.white.opacity(0.8)),
        cornerRadius: 12,
        shadowColor: EarthTheme.cardShadow.opacity(0.5),
        shadowRadius: 4,
        shadowOffset: CGSize(width: 0, height: 2)
    )
    
    static let prominent = CardStyle(
        padding: 20,
        background: AnyView(EarthTheme.primary.opacity(0.1)),
        cornerRadius: 20,
        shadowColor: EarthTheme.cardShadow,
        shadowRadius: 12,
        shadowOffset: CGSize(width: 0, height: 6)
    )
}

#Preview {
    VStack(spacing: 16) {
        Card(style: .default) {
            Text("Default Card")
                .font(.headline)
        }
        
        Card(style: .subtle) {
            Text("Subtle Card")
                .font(.subheadline)
        }
        
        Card(style: .prominent) {
            Text("Prominent Card")
                .font(.title3)
        }
    }
    .padding()
    .background(EarthTheme.backgroundGradient)
}
