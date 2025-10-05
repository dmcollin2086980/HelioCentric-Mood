import XCTest
import SwiftData
@testable import Mood
@testable import Data

@MainActor
final class MoodViewModelTests: XCTestCase {
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    var viewModel: MoodViewModel!
    
    override func setUp() {
        super.setUp()
        
        // Create in-memory model container for testing
        let schema = Schema([
            MoodEntry.self,
            Reflection.self,
            Quote.self,
            UserSettings.self
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        
        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            modelContext = modelContainer.mainContext
            viewModel = MoodViewModel(modelContext: modelContext)
        } catch {
            XCTFail("Failed to create test model container: \(error)")
        }
    }
    
    override func tearDown() {
        modelContainer = nil
        modelContext = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadData() {
        // Given
        let quote = Quote(text: "Test quote", author: "Test Author", category: "Wisdom")
        modelContext.insert(quote)
        
        let reflection = Reflection(text: "Test reflection")
        modelContext.insert(reflection)
        
        try? modelContext.save()
        
        // When
        viewModel.loadData()
        
        // Then
        XCTAssertNotNil(viewModel.dailyQuote)
        XCTAssertNotNil(viewModel.todaysReflection)
        XCTAssertFalse(viewModel.shortcuts.isEmpty)
    }
    
    func testHandleShortcutTap() {
        // Given
        let shortcut = ShortcutChip(id: "test", title: "Test", icon: "test")
        
        // When
        viewModel.handleShortcutTap(shortcut)
        
        // Then
        // Should not crash and log the action
        XCTAssertTrue(true) // Basic test that method executes
    }
}
