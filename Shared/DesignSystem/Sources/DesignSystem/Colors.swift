import SwiftUI

struct EarthTheme {
    // Primary colors
    static let primary = Color(red: 0.2, green: 0.6, blue: 0.4)
    static let secondary = Color(red: 0.4, green: 0.7, blue: 0.5)
    static let accent = Color(red: 0.8, green: 0.4, blue: 0.2)
    
    // Background colors
    static let background = Color(red: 0.95, green: 0.97, blue: 0.98)
    static let surface = Color.white
    static let cardBackground = Color.white.opacity(0.9)
    
    // Text colors
    static let textPrimary = Color(red: 0.1, green: 0.1, blue: 0.1)
    static let textSecondary = Color(red: 0.4, green: 0.4, blue: 0.4)
    static let textTertiary = Color(red: 0.6, green: 0.6, blue: 0.6)
    
    // Gradient backgrounds
    static let backgroundGradient = LinearGradient(
        colors: [
            Color(red: 0.9, green: 0.95, blue: 0.98),
            Color(red: 0.85, green: 0.92, blue: 0.96)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let orbitGradient = RadialGradient(
        colors: [
            Color(red: 0.3, green: 0.7, blue: 0.9).opacity(0.1),
            Color(red: 0.2, green: 0.6, blue: 0.4).opacity(0.05),
            Color.clear
        ],
        center: .center,
        startRadius: 50,
        endRadius: 200
    )
    
    // Shadow colors
    static let cardShadow = Color.black.opacity(0.08)
    static let buttonShadow = Color.black.opacity(0.12)
}

// Dark mode support
extension Color {
    static let adaptiveBackground = Color(.systemBackground)
    static let adaptiveSurface = Color(.secondarySystemBackground)
    static let adaptiveTextPrimary = Color(.label)
    static let adaptiveTextSecondary = Color(.secondaryLabel)
}
