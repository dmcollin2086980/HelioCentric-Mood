import Foundation
import SwiftData
import Core
import Data

@MainActor
final class QuotesViewModel: ObservableObject {
    @Published var todaysQuote: Quote?
    @Published var categories: [QuoteCategoryInfo] = []
    @Published var selectedCategory: QuoteCategory?
    @Published var categoryQuotes: [Quote] = []
    @Published var showQuoteList: Bool = false
    
    private let modelContext: ModelContext
    private let logger: Logger
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.logger = Logger(subsystem: "com.helioCentric.mood", category: "QuotesViewModel")
    }
    
    func loadData() {
        loadTodaysQuote()
        loadCategories()
    }
    
    private func loadTodaysQuote() {
        let descriptor = FetchDescriptor<Quote>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        do {
            let quotes = try modelContext.fetch(descriptor)
            todaysQuote = quotes.randomElement()
        } catch {
            logger.error("Failed to load today's quote: \(error)")
        }
    }
    
    private func loadCategories() {
        let descriptor = FetchDescriptor<Quote>()
        
        do {
            let allQuotes = try modelContext.fetch(descriptor)
            let categoryCounts = Dictionary(grouping: allQuotes, by: { $0.category })
                .mapValues { $0.count }
            
            categories = QuoteCategory.allCases.map { category in
                QuoteCategoryInfo(
                    category: category,
                    count: categoryCounts[category.rawValue] ?? 0
                )
            }
        } catch {
            logger.error("Failed to load categories: \(error)")
        }
    }
    
    func loadRandomQuote() {
        let descriptor = FetchDescriptor<Quote>()
        
        do {
            let quotes = try modelContext.fetch(descriptor)
            todaysQuote = quotes.randomElement()
        } catch {
            logger.error("Failed to load random quote: \(error)")
        }
    }
    
    func selectCategory(_ category: QuoteCategory) {
        selectedCategory = category
        loadCategoryQuotes()
        showQuoteList = true
    }
    
    private func loadCategoryQuotes() {
        guard let category = selectedCategory else { return }
        
        let descriptor = FetchDescriptor<Quote>(
            predicate: #Predicate<Quote> { quote in
                quote.category == category.rawValue
            },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        do {
            categoryQuotes = try modelContext.fetch(descriptor)
        } catch {
            logger.error("Failed to load category quotes: \(error)")
        }
    }
    
    func handleQuoteTap(_ quote: Quote) {
        logger.info("Quote tapped: \(quote.id)")
        // TODO: Implement quote actions (favorite, share, etc.)
    }
}

struct QuoteCategoryInfo {
    let category: QuoteCategory
    let count: Int
}
