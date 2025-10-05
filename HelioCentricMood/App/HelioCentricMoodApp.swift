import SwiftUI
import SwiftData

@main
struct HelioCentricMoodApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "sun.max")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                
                Text("HelioCentric Mood")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Version 1.0.0")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("A modern iOS app for mood tracking, reflection journaling, and wisdom discovery")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                Text("Coming Soon")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}
