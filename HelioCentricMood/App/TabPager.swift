import SwiftUI
import Core
import Mood
import Reflect
import Journal
import Quotes
import Settings

struct TabPager: View {
    @Binding var selectedTab: Tab
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MoodView()
                .tag(Tab.mood)
            
            ReflectView()
                .tag(Tab.reflect)
            
            JournalView()
                .tag(Tab.journal)
            
            QuotesView()
                .tag(Tab.quotes)
            
            SettingsView()
                .tag(Tab.settings)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.8), value: selectedTab)
        .onChange(of: selectedTab) { _, newTab in
            appState.hapticsService.triggerTabChange()
        }
    }
}

#Preview {
    TabPager(selectedTab: .constant(.mood))
        .environmentObject(AppState())
}
