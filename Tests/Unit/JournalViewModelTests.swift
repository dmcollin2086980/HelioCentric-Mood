import XCTest
import SwiftData
@testable import Journal
@testable import Data

@MainActor
final class JournalViewModelTests: XCTestCase {
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    var viewModel: JournalViewModel!
    
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
            viewModel = JournalViewModel(modelContext: modelContext)
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
    
    func testSelectEmoji() {
        // Given
        let emoji = "😊"
        
        // When
        viewModel.selectEmoji(emoji)
        
        // Then
        XCTAssertEqual(viewModel.selectedEmoji, emoji)
    }
    
    func testUpdateIntensity() {
        // Given
        let intensity = 8
        
        // When
        viewModel.updateIntensity(intensity)
        
        // Then
        XCTAssertEqual(viewModel.intensity, intensity)
    }
    
    func testSaveMoodEntry() {
        // Given
        viewModel.selectedEmoji = "😊"
        viewModel.intensity = 7
        viewModel.note = "Feeling great today!"
        
        // When
        viewModel.saveMoodEntry()
        
        // Then
        XCTAssertTrue(viewModel.selectedEmoji.isEmpty)
        XCTAssertEqual(viewModel.intensity, 5) // Reset to default
        XCTAssertTrue(viewModel.note.isEmpty)
        XCTAssertTrue(viewModel.showSuccessBanner)
    }
    
    func testSaveMoodEntryWithoutEmoji() {
        // Given
        viewModel.selectedEmoji = ""
        viewModel.intensity = 7
        viewModel.note = "Feeling great today!"
        
        // When
        viewModel.saveMoodEntry()
        
        // Then
        XCTAssertFalse(viewModel.showSuccessBanner)
    }
}
