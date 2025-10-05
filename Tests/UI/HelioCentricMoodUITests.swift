import XCTest

final class HelioCentricMoodUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testTabNavigation() throws {
        // Test that all tabs are accessible
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.exists)
        
        // Test Mood tab (default)
        let moodTab = app.buttons["Mood"]
        XCTAssertTrue(moodTab.exists)
        XCTAssertTrue(moodTab.isSelected)
        
        // Test Reflect tab
        let reflectTab = app.buttons["Reflect"]
        XCTAssertTrue(reflectTab.exists)
        reflectTab.tap()
        XCTAssertTrue(reflectTab.isSelected)
        
        // Test Journal tab
        let journalTab = app.buttons["Journal"]
        XCTAssertTrue(journalTab.exists)
        journalTab.tap()
        XCTAssertTrue(journalTab.isSelected)
        
        // Test Quotes tab
        let quotesTab = app.buttons["Quotes"]
        XCTAssertTrue(quotesTab.exists)
        quotesTab.tap()
        XCTAssertTrue(quotesTab.isSelected)
        
        // Test Settings tab
        let settingsTab = app.buttons["Settings"]
        XCTAssertTrue(settingsTab.exists)
        settingsTab.tap()
        XCTAssertTrue(settingsTab.isSelected)
    }
    
    func testMoodEntryCreation() throws {
        // Navigate to Journal tab
        app.buttons["Journal"].tap()
        
        // Select an emoji
        let emojiButton = app.buttons["😊"]
        if emojiButton.exists {
            emojiButton.tap()
        }
        
        // Adjust intensity slider
        let intensitySlider = app.sliders.firstMatch
        if intensitySlider.exists {
            intensitySlider.adjust(toNormalizedPosition: 0.7)
        }
        
        // Enter note
        let noteField = app.textViews.firstMatch
        if noteField.exists {
            noteField.tap()
            noteField.typeText("Feeling great today!")
        }
        
        // Save entry
        let saveButton = app.buttons["Save Entry"]
        if saveButton.exists && saveButton.isEnabled {
            saveButton.tap()
        }
    }
    
    func testReflectionCreation() throws {
        // Navigate to Reflect tab
        app.buttons["Reflect"].tap()
        
        // Enter reflection text
        let reflectionField = app.textViews.firstMatch
        if reflectionField.exists {
            reflectionField.tap()
            reflectionField.typeText("Today I practiced mindfulness and felt more centered.")
        }
        
        // Save reflection
        let saveButton = app.buttons["Save Reflection"]
        if saveButton.exists && saveButton.isEnabled {
            saveButton.tap()
        }
    }
    
    func testSettingsToggles() throws {
        // Navigate to Settings tab
        app.buttons["Settings"].tap()
        
        // Test haptics toggle
        let hapticsToggle = app.switches["Haptic Feedback"]
        if hapticsToggle.exists {
            let initialState = hapticsToggle.value as? String
            hapticsToggle.tap()
            let newState = hapticsToggle.value as? String
            XCTAssertNotEqual(initialState, newState)
        }
        
        // Test dark mode toggle
        let darkModeToggle = app.switches["Dark Mode"]
        if darkModeToggle.exists {
            let initialState = darkModeToggle.value as? String
            darkModeToggle.tap()
            let newState = darkModeToggle.value as? String
            XCTAssertNotEqual(initialState, newState)
        }
    }
    
    func testSwipeNavigation() throws {
        // Start on Mood tab
        XCTAssertTrue(app.buttons["Mood"].isSelected)
        
        // Swipe to Reflect tab
        app.swipeLeft()
        XCTAssertTrue(app.buttons["Reflect"].isSelected)
        
        // Swipe to Journal tab
        app.swipeLeft()
        XCTAssertTrue(app.buttons["Journal"].isSelected)
        
        // Swipe to Quotes tab
        app.swipeLeft()
        XCTAssertTrue(app.buttons["Quotes"].isSelected)
        
        // Swipe to Settings tab
        app.swipeLeft()
        XCTAssertTrue(app.buttons["Settings"].isSelected)
        
        // Swipe back to Mood tab
        app.swipeRight()
        XCTAssertTrue(app.buttons["Mood"].isSelected)
    }
}
