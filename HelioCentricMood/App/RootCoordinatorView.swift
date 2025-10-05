import SwiftUI
import Core
import DesignSystem

struct RootCoordinatorView: View {
    @EnvironmentObject private var appState: AppState
    @State private var selectedTab: Tab = .mood
    
    var body: some View {
        ZStack {
            // Background
            EarthTheme.backgroundGradient
                .ignoresSafeArea()
            
            // Main content
            TabPager(selectedTab: $selectedTab)
            
            // Bottom toolbar
            VStack {
                Spacer()
                BottomToolbar(selectedTab: $selectedTab)
            }
        }
        .onAppear {
            appState.initialize()
        }
    }
}

#Preview {
    RootCoordinatorView()
        .environmentObject(AppState())
}
