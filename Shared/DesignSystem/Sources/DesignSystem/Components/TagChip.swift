import SwiftUI

struct TagChip: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    init(
        _ text: String,
        isSelected: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.text = text
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.caption.weight(.medium))
                .foregroundColor(isSelected ? .white : EarthTheme.textSecondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? EarthTheme.primary : Color.white.opacity(0.8))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isSelected ? Color.clear : EarthTheme.primary.opacity(0.3),
                            lineWidth: 1
                        )
                )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    HStack(spacing: 8) {
        TagChip("Energy", isSelected: true) {}
        TagChip("Week") {}
        TagChip("Journal") {}
        TagChip("Reflect") {}
    }
    .padding()
    .background(EarthTheme.backgroundGradient)
}
