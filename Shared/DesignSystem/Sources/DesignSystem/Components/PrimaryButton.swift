import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    let style: ButtonStyle
    
    init(
        _ title: String,
        style: ButtonStyle = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline.weight(.medium))
                .foregroundColor(style.textColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
                .background(style.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(
                    color: style.shadowColor,
                    radius: style.shadowRadius,
                    x: 0,
                    y: style.shadowOffset
                )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(style.scaleEffect)
        .animation(.easeInOut(duration: 0.1), value: style.scaleEffect)
    }
}

struct ButtonStyle {
    let backgroundColor: Color
    let textColor: Color
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowOffset: CGFloat
    let scaleEffect: CGFloat
    
    static let primary = ButtonStyle(
        backgroundColor: EarthTheme.primary,
        textColor: .white,
        shadowColor: EarthTheme.buttonShadow,
        shadowRadius: 8,
        shadowOffset: 4,
        scaleEffect: 1.0
    )
    
    static let secondary = ButtonStyle(
        backgroundColor: Color.white,
        textColor: EarthTheme.primary,
        shadowColor: EarthTheme.cardShadow,
        shadowRadius: 4,
        shadowOffset: 2,
        scaleEffect: 1.0
    )
    
    static let subtle = ButtonStyle(
        backgroundColor: EarthTheme.primary.opacity(0.1),
        textColor: EarthTheme.primary,
        shadowColor: .clear,
        shadowRadius: 0,
        shadowOffset: 0,
        scaleEffect: 1.0
    )
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton("Primary Button", style: .primary) {
            print("Primary tapped")
        }
        
        PrimaryButton("Secondary Button", style: .secondary) {
            print("Secondary tapped")
        }
        
        PrimaryButton("Subtle Button", style: .subtle) {
            print("Subtle tapped")
        }
    }
    .padding()
    .background(EarthTheme.backgroundGradient)
}
