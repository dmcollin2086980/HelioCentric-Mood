import SwiftUI
import DesignSystem
import Core
import Data

struct MoodView: View {
    @StateObject private var viewModel = MoodViewModel()
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Daily quote banner
                DailyQuoteBanner(quote: viewModel.dailyQuote)
                
                // Central focus card
                CentralFocusCard()
                
                // Orbiting shortcut chips
                OrbitView(
                    shortcuts: viewModel.shortcuts,
                    onShortcutTapped: viewModel.handleShortcutTap
                )
                
                // Today's reflection teaser
                if let reflection = viewModel.todaysReflection {
                    ReflectionTeaser(reflection: reflection)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 100) // Space for bottom toolbar
        }
        .background(EarthTheme.backgroundGradient)
        .onAppear {
            viewModel.loadData()
        }
    }
}

struct DailyQuoteBanner: View {
    let quote: Quote?
    
    var body: some View {
        if let quote = quote {
            Card(style: .subtle) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(quote.text)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(EarthTheme.textPrimary)
                        .multilineTextAlignment(.leading)
                    
                    if let author = quote.author {
                        Text("— \(author)")
                            .font(.caption.weight(.medium))
                            .foregroundColor(EarthTheme.textSecondary)
                    }
                }
            }
        }
    }
}

struct CentralFocusCard: View {
    var body: some View {
        Card(style: .prominent) {
            VStack(spacing: 16) {
                Image(systemName: "target")
                    .font(.system(size: 48, weight: .light))
                    .foregroundColor(EarthTheme.primary)
                
                Text("Focus / Present")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(EarthTheme.textPrimary)
                
                Text("Take a moment to center yourself and focus on the present moment")
                    .font(.subheadline)
                    .foregroundColor(EarthTheme.textSecondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 8)
        }
    }
}

struct OrbitView: View {
    let shortcuts: [ShortcutChip]
    let onShortcutTapped: (ShortcutChip) -> Void
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    var body: some View {
        ZStack {
            // Orbit rings
            if !reduceMotion {
                OrbitRings()
            }
            
            // Shortcut chips arranged in orbit
            ForEach(Array(shortcuts.enumerated()), id: \.element.id) { index, shortcut in
                let angle = Double(index) * (2 * .pi / Double(shortcuts.count))
                let radius: CGFloat = 120
                
                TagChip(shortcut.title, isSelected: false) {
                    onShortcutTapped(shortcut)
                }
                .position(
                    x: cos(angle) * radius + 200,
                    y: sin(angle) * radius + 200
                )
                .animation(
                    reduceMotion ? .none : .easeInOut(duration: 0.6).delay(Double(index) * 0.1),
                    value: shortcuts.count
                )
            }
        }
        .frame(height: 400)
    }
}

struct OrbitRings: View {
    var body: some View {
        ZStack {
            // Outer ring
            Circle()
                .stroke(EarthTheme.primary.opacity(0.1), lineWidth: 1)
                .frame(width: 240, height: 240)
            
            // Middle ring
            Circle()
                .stroke(EarthTheme.primary.opacity(0.15), lineWidth: 1)
                .frame(width: 180, height: 180)
            
            // Inner ring
            Circle()
                .stroke(EarthTheme.primary.opacity(0.2), lineWidth: 1)
                .frame(width: 120, height: 120)
        }
    }
}

struct ReflectionTeaser: View {
    let reflection: Reflection
    
    var body: some View {
        Card(style: .default) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Today's Reflection")
                    .font(.headline.weight(.semibold))
                    .foregroundColor(EarthTheme.textPrimary)
                
                Text(reflection.previewText)
                    .font(.subheadline)
                    .foregroundColor(EarthTheme.textSecondary)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text(reflection.createdAt, style: .time)
                        .font(.caption.weight(.medium))
                        .foregroundColor(EarthTheme.textTertiary)
                    
                    Spacer()
                    
                    if let duration = reflection.durationFormatted {
                        Text(duration)
                            .font(.caption.weight(.medium))
                            .foregroundColor(EarthTheme.textTertiary)
                    }
                }
            }
        }
    }
}

#Preview {
    MoodView()
}
