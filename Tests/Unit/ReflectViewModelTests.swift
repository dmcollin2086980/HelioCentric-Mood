import XCTest
import SwiftData
@testable import Reflect
@testable import Data

@MainActor
final class ReflectViewModelTests: XCTestCase {
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    var viewModel: ReflectViewModel!
    
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
            viewModel = ReflectViewModel(modelContext: modelContext)
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
    
    func testSaveReflection() {
        // Given
        viewModel.reflectionText = "Test reflection text"
        viewModel.startReflection()
        
        // When
        viewModel.saveReflection()
        
        // Then
        XCTAssertTrue(viewModel.reflectionText.isEmpty)
        XCTAssertTrue(viewModel.showSuccessBanner)
        XCTAssertEqual(viewModel.previousReflections.count, 1)
    }
    
    func testSaveEmptyReflection() {
        // Given
        viewModel.reflectionText = ""
        
        // When
        viewModel.saveReflection()
        
        // Then
        XCTAssertEqual(viewModel.previousReflections.count, 0)
        XCTAssertFalse(viewModel.showSuccessBanner)
    }
    
    func testSelectReflection() {
        // Given
        let reflection = Reflection(text: "Existing reflection")
        modelContext.insert(reflection)
        try? modelContext.save()
        
        viewModel.loadReflections()
        
        // When
        viewModel.selectReflection(reflection)
        
        // Then
        XCTAssertEqual(viewModel.reflectionText, "Existing reflection")
    }
}
