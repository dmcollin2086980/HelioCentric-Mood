import SwiftUI
import DesignSystem
import Core
import Data

struct JournalView: View {
    @StateObject private var viewModel = JournalViewModel()
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                JournalHeader()
                
                // Mood emoji selection
                MoodEmojiSelector(
                    selectedEmoji: $viewModel.selectedEmoji,
                    onEmojiSelected: viewModel.selectEmoji
                )
                
                // Intensity slider
                IntensitySlider(
                    intensity: $viewModel.intensity,
                    onIntensityChanged: viewModel.updateIntensity
                )
                
                // Reflection prompt
                ReflectionPrompt(
                    text: $viewModel.note,
                    onSave: viewModel.saveMoodEntry
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 100) // Space for bottom toolbar
        }
        .background(EarthTheme.backgroundGradient)
        .overlay(alignment: .top) {
            if viewModel.showSuccessBanner {
                BannerToast(
                    message: "Mood entry saved!",
                    type: .success,
                    isPresented: $viewModel.showSuccessBanner
                )
                .padding(.top, 8)
            }
        }
    }
}

struct JournalHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mood Journal")
                .font(.largeTitle.weight(.bold))
                .foregroundColor(EarthTheme.textPrimary)
            
            Text("Track your emotional journey and gain insights")
                .font(.subheadline)
                .foregroundColor(EarthTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MoodEmojiSelector: View {
    @Binding var selectedEmoji: String
    let onEmojiSelected: (String) -> Void
    
    private let moodEmojis = [
        ("😊", "Happy"),
        ("😌", "Calm"),
        ("😢", "Sad"),
        ("😡", "Angry"),
        ("😰", "Anxious"),
        ("😴", "Tired"),
        ("🤔", "Thoughtful"),
        ("😤", "Frustrated"),
        ("😍", "Excited"),
        ("😔", "Disappointed")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How are you feeling?")
                .font(.headline.weight(.semibold))
                .foregroundColor(EarthTheme.textPrimary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 12) {
                ForEach(moodEmojis, id: \.0) { emoji, label in
                    Button(action: {
                        selectedEmoji = emoji
                        onEmojiSelected(emoji)
                    }) {
                        VStack(spacing: 4) {
                            Text(emoji)
                                .font(.system(size: 32))
                            
                            Text(label)
                                .font(.caption2.weight(.medium))
                                .foregroundColor(EarthTheme.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedEmoji == emoji ? EarthTheme.primary.opacity(0.1) : Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    selectedEmoji == emoji ? EarthTheme.primary : Color.clear,
                                    lineWidth: 2
                                )
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct IntensitySlider: View {
    @Binding var intensity: Int
    let onIntensityChanged: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Intensity Level")
                    .font(.headline.weight(.semibold))
                    .foregroundColor(EarthTheme.textPrimary)
                
                Spacer()
                
                Text("Level: \(intensity) — \(intensityDescription)")
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(EarthTheme.textSecondary)
            }
            
            VStack(spacing: 8) {
                Slider(
                    value: Binding(
                        get: { Double(intensity) },
                        set: { newValue in
                            intensity = Int(newValue.rounded())
                            onIntensityChanged(intensity)
                        }
                    ),
                    in: 0...10,
                    step: 1
                )
                .accentColor(EarthTheme.primary)
                
                HStack {
                    Text("0")
                        .font(.caption.weight(.medium))
                        .foregroundColor(EarthTheme.textTertiary)
                    
                    Spacer()
                    
                    Text("10")
                        .font(.caption.weight(.medium))
                        .foregroundColor(EarthTheme.textTertiary)
                }
            }
        }
    }
    
    private var intensityDescription: String {
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

struct ReflectionPrompt: View {
    @Binding var text: String
    let onSave: () -> Void
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Why do you feel this way?")
                .font(.headline.weight(.semibold))
                .foregroundColor(EarthTheme.textPrimary)
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                isFocused ? EarthTheme.primary : Color.clear,
                                lineWidth: 2
                            )
                    )
                    .shadow(color: EarthTheme.cardShadow, radius: 8, x: 0, y: 4)
                
                TextEditor(text: $text)
                    .font(.body)
                    .foregroundColor(EarthTheme.textPrimary)
                    .padding(16)
                    .focused($isFocused)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
            }
            .frame(minHeight: 120)
            
            PrimaryButton("Save Entry", style: .primary) {
                onSave()
            }
            .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
}

#Preview {
    JournalView()
}
