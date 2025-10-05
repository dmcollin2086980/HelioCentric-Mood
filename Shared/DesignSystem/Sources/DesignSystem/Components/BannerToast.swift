import SwiftUI

struct BannerToast: View {
    let message: String
    let type: ToastType
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            HStack {
                Image(systemName: type.iconName)
                    .foregroundColor(type.iconColor)
                
                Text(message)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(type.textColor)
                
                Spacer()
                
                Button("Dismiss") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPresented = false
                    }
                }
                .font(.caption.weight(.medium))
                .foregroundColor(type.textColor.opacity(0.7))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(type.backgroundColor)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal, 20)
            .transition(.asymmetric(
                insertion: .move(edge: .top).combined(with: .opacity),
                removal: .move(edge: .top).combined(with: .opacity)
            ))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPresented = false
                    }
                }
            }
        }
    }
}

enum ToastType {
    case success
    case error
    case info
    
    var backgroundColor: Color {
        switch self {
        case .success: return Color.green.opacity(0.1)
        case .error: return Color.red.opacity(0.1)
        case .info: return Color.blue.opacity(0.1)
        }
    }
    
    var textColor: Color {
        switch self {
        case .success: return Color.green
        case .error: return Color.red
        case .info: return Color.blue
        }
    }
    
    var iconColor: Color {
        textColor
    }
    
    var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }
}

#Preview {
    VStack {
        BannerToast(
            message: "Reflection saved successfully!",
            type: .success,
            isPresented: .constant(true)
        )
        
        BannerToast(
            message: "Failed to save mood entry",
            type: .error,
            isPresented: .constant(true)
        )
        
        BannerToast(
            message: "iCloud sync is unavailable",
            type: .info,
            isPresented: .constant(true)
        )
    }
    .background(EarthTheme.backgroundGradient)
}
