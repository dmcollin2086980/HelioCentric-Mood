# HelioCentric Mood (10.5.25)

A modern iOS app for mood tracking, reflection journaling, and wisdom discovery, built with SwiftUI and SwiftData.

## 🌟 Features

### Core Functionality
- **Mood Tracking**: Emoji-based mood selection with intensity levels (0-10)
- **Reflection Journal**: Rich text reflection entries with duration tracking
- **Wisdom Quotes**: Curated quotes across 10 categories with favorites
- **Settings**: Theme selection, haptics, privacy controls, and iCloud sync

### Design & UX
- **Heliocentric Theme**: Earth-inspired design with orbital motifs
- **Swipe Navigation**: Horizontal tab swiping with persistent bottom toolbar
- **Accessibility**: VoiceOver, Dynamic Type, Reduce Motion support
- **Performance**: 120fps-friendly animations, GPU-light gradients

## 🏗️ Architecture

### Multi-Module Structure
The app uses a clean, modular architecture with local Swift Packages:

```
HelioCentricMood/
├── App/                    # Main app target
├── Shared/
│   ├── DesignSystem/       # UI components, colors, typography
│   ├── Core/              # AppState, Router, HapticsService
│   └── Data/              # SwiftData models, repositories
└── Features/
    ├── Mood/              # Mood tracking feature
    ├── Reflect/           # Reflection journaling
    ├── Journal/           # Mood journal entries
    ├── Quotes/            # Wisdom quotes
    └── Settings/          # App configuration
```

### Design Patterns
- **MVVM**: ViewModels handle business logic, Views are purely declarative
- **Repository Pattern**: Protocol-based data access with SwiftData implementation
- **Coordinator**: Lightweight navigation coordination
- **Swift Concurrency**: Async/await throughout for data operations

## 📱 Screens

### 1. Mood (Home)
- Central focus card with "Focus / Present" theme
- Orbiting shortcut chips for quick navigation
- Daily wisdom quote banner
- Today's reflection teaser

### 2. Reflect
- Large text input for reflections
- Previous reflections list with previews
- Duration tracking for reflection sessions
- Success feedback with banners

### 3. Journal (Mood Journal)
- Emoji mood selector (10 common moods)
- Intensity slider (0-10) with descriptive labels
- "Why do you feel this way?" prompt
- Save mood entries to SwiftData

### 4. Quotes
- "Wisdom for Today" featured quote
- Category grid (Action, Anger, Control, Fear, etc.)
- Random quote generation
- Favorites system

### 5. Settings
- App info (Version 1.0.0, Build V99)
- Theme picker (Earth, System, Light, Dark)
- Haptics and Dark Mode toggles
- iCloud Sync and Privacy Lock controls
- Support links

## 🛠️ Technical Implementation

### Data Layer
- **SwiftData**: Modern Core Data replacement with CloudKit integration
- **Models**: MoodEntry, Reflection, Quote, UserSettings
- **Persistence**: Local-first with optional iCloud sync
- **Migration**: Automatic schema evolution

### Security & Privacy
- **Privacy Lock**: Face ID/Touch ID authentication for sensitive data
- **Local-First**: No third-party analytics or tracking
- **NSPrivacyManifest**: Declares data usage and tracking policies
- **Keychain**: Optional encryption for reflection text

### Performance
- **ProMotion**: 120fps-friendly animations
- **Reduce Motion**: Respects accessibility preferences
- **GPU Optimization**: Light gradients, no heavy blur stacks
- **Memory Efficient**: Lazy loading and proper cleanup

## 🚀 Getting Started

### Prerequisites
- Xcode 15.4+
- iOS 17.0+ deployment target
- Swift 5.10+

### Installation
1. Open `HelioCentricMood.xcworkspace` in Xcode
2. Select your target device (iPhone 17 Pro Max recommended)
3. Build and run (⌘+R)

### First Run
The app includes seed data with:
- 12+ Stoic wisdom quotes across categories
- Sample mood entry and reflection
- Default settings configuration

## 🧪 Testing

### Unit Tests
```bash
# Run unit tests
xcodebuild test -workspace HelioCentricMood.xcworkspace -scheme HelioCentricMood -destination 'platform=iOS Simulator,name=iPhone 17 Pro Max'
```

### UI Tests
- Tab navigation and swipe gestures
- Mood entry creation and persistence
- Reflection saving and loading
- Settings toggles and persistence

### Test Coverage
- ViewModels: Business logic and state management
- Repositories: Data access and persistence
- Models: SwiftData model validation

## 📦 Build Configuration

### Schemes
- **Debug**: Development with logging and debug symbols
- **Release**: Production build with optimizations
- **POC-Demo**: Demo scheme with seed data on first run

### Build Settings
- Minimum iOS: 17.0
- Swift Version: 5.10+
- Deployment Target: iPhone 17 Pro Max and smaller
- Architecture: arm64

## 🔧 Development

### Code Style
- SwiftLint integration for code quality
- Consistent naming conventions
- Comprehensive documentation
- Unit test coverage

### Extensions Points
- **New Features**: Add to Features/ directory
- **UI Components**: Extend DesignSystem module
- **Data Models**: Add to Data module with proper indexing
- **Themes**: Extend EarthTheme with new color schemes

## 📋 TODO / Future Enhancements

### Phase 1 (Current)
- [x] Core architecture and navigation
- [x] Mood tracking and reflection journaling
- [x] Wisdom quotes with categories
- [x] Settings and privacy controls

### Phase 2 (Planned)
- [ ] Advanced analytics and insights
- [ ] Export functionality (PDF, Markdown)
- [ ] Widget support for quick mood entry
- [ ] Apple Watch companion app

### Phase 3 (Future)
- [ ] Machine learning mood predictions
- [ ] Social sharing (privacy-preserving)
- [ ] Advanced reflection prompts
- [ ] Meditation and mindfulness features

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the coding standards
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

- **Privacy Policy**: Available in Settings
- **Help & Support**: Contact through Settings
- **Issues**: Report bugs via GitHub Issues

---

**HelioCentric Mood** - Centering your emotional journey through mindful reflection and timeless wisdom.
