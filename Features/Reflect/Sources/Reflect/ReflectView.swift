import SwiftUI
import DesignSystem
import Core
import Data

struct ReflectView: View {
    @StateObject private var viewModel = ReflectViewModel()
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                ReflectHeader()
                
                // Reflection input
                ReflectionInput(
                    text: $viewModel.reflectionText,
                    onSave: viewModel.saveReflection
                )
                
                // Previous reflections
                PreviousReflectionsList(
                    reflections: viewModel.previousReflections,
                    onReflectionTapped: viewModel.selectReflection
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 100) // Space for bottom toolbar
        }
        .background(EarthTheme.backgroundGradient)
        .onAppear {
            viewModel.loadReflections()
        }
        .overlay(alignment: .top) {
            if viewModel.showSuccessBanner {
                BannerToast(
                    message: "Reflection saved successfully!",
                    type: .success,
                    isPresented: $viewModel.showSuccessBanner
                )
                .padding(.top, 8)
            }
        }
    }
}

struct ReflectHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Reflect")
                .font(.largeTitle.weight(.bold))
                .foregroundColor(EarthTheme.textPrimary)
            
            Text("Take time to reflect on your thoughts and experiences")
                .font(.subheadline)
                .foregroundColor(EarthTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ReflectionInput: View {
    @Binding var text: String
    let onSave: () -> Void
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Reflection")
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
            .frame(minHeight: 200)
            
            PrimaryButton("Save Reflection", style: .primary) {
                onSave()
            }
            .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
}

struct PreviousReflectionsList: View {
    let reflections: [Reflection]
    let onReflectionTapped: (Reflection) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Previous Reflections")
                .font(.headline.weight(.semibold))
                .foregroundColor(EarthTheme.textPrimary)
            
            if reflections.isEmpty {
                EmptyReflectionsView()
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(reflections) { reflection in
                        ReflectionCard(
                            reflection: reflection,
                            onTap: { onReflectionTapped(reflection) }
                        )
                    }
                }
            }
        }
    }
}

struct ReflectionCard: View {
    let reflection: Reflection
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Card(style: .default) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(reflection.previewText)
                        .font(.subheadline)
                        .foregroundColor(EarthTheme.textPrimary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    
                    HStack {
                        Text(reflection.createdAt, style: .date)
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
        .buttonStyle(PlainButtonStyle())
    }
}

struct EmptyReflectionsView: View {
    var body: some View {
        Card(style: .subtle) {
            VStack(spacing: 12) {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 32, weight: .light))
                    .foregroundColor(EarthTheme.textTertiary)
                
                Text("No reflections yet")
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(EarthTheme.textSecondary)
                
                Text("Start your reflection journey by writing your first thought")
                    .font(.caption)
                    .foregroundColor(EarthTheme.textTertiary)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    ReflectView()
}
