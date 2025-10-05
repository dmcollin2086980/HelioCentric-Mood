import SwiftUI
import Core
import DesignSystem

struct BottomToolbar: View {
    @Binding var selectedTab: Tab
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    private let tabs: [Tab] = [.mood, .reflect, .journal, .quotes, .settings]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                ToolbarButton(
                    tab: tab,
                    isSelected: selectedTab == tab
                ) {
                    withAnimation(reduceMotion ? .none : .interactiveSpring(response: 0.4, dampingFraction: 0.8)) {
                        selectedTab = tab
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

struct ToolbarButton: View {
    let tab: Tab
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: tab.iconName)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(isSelected ? .white : .secondary)
                
                Text(tab.title)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(isSelected ? .white : .secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white.opacity(0.2))
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(tab.accessibilityLabel)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    VStack {
        Spacer()
        BottomToolbar(selectedTab: .constant(.mood))
    }
    .background(EarthTheme.backgroundGradient)
}
