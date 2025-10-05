import Foundation
import SwiftData
import Core
import Data

@MainActor
final class ReflectViewModel: ObservableObject {
    @Published var reflectionText: String = ""
    @Published var previousReflections: [Reflection] = []
    @Published var showSuccessBanner: Bool = false
    
    private let modelContext: ModelContext
    private let logger: Logger
    private var reflectionStartTime: Date?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.logger = Logger(subsystem: "com.helioCentric.mood", category: "ReflectViewModel")
    }
    
    func loadReflections() {
        let descriptor = FetchDescriptor<Reflection>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        do {
            previousReflections = try modelContext.fetch(descriptor)
        } catch {
            logger.error("Failed to load reflections: \(error)")
        }
    }
    
    func saveReflection() {
        guard !reflectionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        let durationSeconds = reflectionStartTime.map { startTime in
            Int(Date().timeIntervalSince(startTime))
        }
        
        let reflection = Reflection(
            text: reflectionText.trimmingCharacters(in: .whitespacesAndNewlines),
            durationSeconds: durationSeconds
        )
        
        modelContext.insert(reflection)
        
        do {
            try modelContext.save()
            logger.info("Reflection saved successfully")
            
            // Update UI
            reflectionText = ""
            previousReflections.insert(reflection, at: 0)
            showSuccessBanner = true
            
        } catch {
            logger.error("Failed to save reflection: \(error)")
        }
    }
    
    func selectReflection(_ reflection: Reflection) {
        reflectionText = reflection.text
        reflectionStartTime = Date()
    }
    
    func startReflection() {
        reflectionStartTime = Date()
    }
}
