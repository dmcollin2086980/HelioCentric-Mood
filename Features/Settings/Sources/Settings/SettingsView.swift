import SwiftUI
import DesignSystem
import Core
import Data

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                SettingsHeader()
                
                // App Info section
                AppInfoSection()
                
                // Preferences section
                PreferencesSection(
                    theme: $viewModel.settings.theme,
                    hapticsEnabled: $viewModel.settings.hapticsEnabled,
                    darkModeEnabled: $viewModel.settings.darkModeEnabled,
                    onThemeChanged: viewModel.updateTheme,
                    onHapticsToggled: viewModel.toggleHaptics,
                    onDarkModeToggled: viewModel.toggleDarkMode
                )
                
                // Data & Privacy section
                DataPrivacySection(
                    iCloudSyncEnabled: $viewModel.settings.iCloudSyncEnabled,
                    privacyLockEnabled: $viewModel.settings.privacyLockEnabled,
                    oniCloudSyncToggled: viewModel.toggleiCloudSync,
                    onPrivacyLockToggled: viewModel.togglePrivacyLock
                )
                
                // Support section
                SupportSection()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 100) // Space for bottom toolbar
        }
        .background(EarthTheme.backgroundGradient)
        .onAppear {
            viewModel.loadSettings()
        }
    }
}

struct SettingsHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Settings")
                .font(.largeTitle.weight(.bold))
                .foregroundColor(EarthTheme.textPrimary)
            
            Text("Customize your experience")
                .font(.subheadline)
                .foregroundColor(EarthTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AppInfoSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("App Info")
                .font(.headline.weight(.semibold))
                .foregroundColor(EarthTheme.textPrimary)
            
            Card(style: .default) {
                VStack(spacing: 12) {
                    InfoRow(title: "Version", value: "1.0.0")
                    InfoRow(title: "Build", value: "V99")
                    InfoRow(title: "Platform", value: "iOS 17.0+")
                }
            }
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundColor(EarthTheme.textPrimary)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(EarthTheme.textSecondary)
        }
    }
}

struct PreferencesSection: View {
    @Binding var theme: String
    @Binding var hapticsEnabled: Bool
    @Binding var darkModeEnabled: Bool
    let onThemeChanged: (String) -> Void
    let onHapticsToggled: () -> Void
    let onDarkModeToggled: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Preferences")
                .font(.headline.weight(.semibold))
                .foregroundColor(EarthTheme.textPrimary)
            
            Card(style: .default) {
                VStack(spacing: 16) {
                    // Theme picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Theme")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(EarthTheme.textPrimary)
                        
                        Picker("Theme", selection: $theme) {
                            ForEach(AppTheme.allCases, id: \.rawValue) { theme in
                                Text(theme.displayName).tag(theme.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: theme) { _, newTheme in
                            onThemeChanged(newTheme)
                        }
                    }
                    
                    Divider()
                    
                    // Haptics toggle
                    ToggleRow(
                        title: "Haptic Feedback",
                        subtitle: "Light vibrations for interactions",
                        isOn: $hapticsEnabled,
                        onToggle: onHapticsToggled
                    )
                    
                    Divider()
                    
                    // Dark Mode toggle
                    ToggleRow(
                        title: "Dark Mode",
                        subtitle: "Use dark appearance",
                        isOn: $darkModeEnabled,
                        onToggle: onDarkModeToggled
                    )
                }
            }
        }
    }
}

struct ToggleRow: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(EarthTheme.textPrimary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(EarthTheme.textSecondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .onChange(of: isOn) { _, _ in
                    onToggle()
                }
        }
    }
}

struct DataPrivacySection: View {
    @Binding var iCloudSyncEnabled: Bool
    @Binding var privacyLockEnabled: Bool
    let oniCloudSyncToggled: () -> Void
    let onPrivacyLockToggled: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Data & Privacy")
                .font(.headline.weight(.semibold))
                .foregroundColor(EarthTheme.textPrimary)
            
            Card(style: .default) {
                VStack(spacing: 16) {
                    // iCloud Sync toggle
                    ToggleRow(
                        title: "iCloud Sync",
                        subtitle: "Sync data across devices",
                        isOn: $iCloudSyncEnabled,
                        onToggle: oniCloudSyncToggled
                    )
                    
                    Divider()
                    
                    // Privacy Lock toggle
                    ToggleRow(
                        title: "Privacy Lock",
                        subtitle: "Use Face ID/Touch ID for sensitive data",
                        isOn: $privacyLockEnabled,
                        onToggle: onPrivacyLockToggled
                    )
                }
            }
        }
    }
}

struct SupportSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Support")
                .font(.headline.weight(.semibold))
                .foregroundColor(EarthTheme.textPrimary)
            
            Card(style: .default) {
                VStack(spacing: 16) {
                    SupportRow(
                        title: "Privacy Policy",
                        icon: "hand.raised.fill",
                        action: {}
                    )
                    
                    Divider()
                    
                    SupportRow(
                        title: "Help & Support",
                        icon: "questionmark.circle.fill",
                        action: {}
                    )
                }
            }
        }
    }
}

struct SupportRow: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundColor(EarthTheme.primary)
                    .frame(width: 20)
                
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(EarthTheme.textPrimary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.medium))
                    .foregroundColor(EarthTheme.textTertiary)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SettingsView()
}
