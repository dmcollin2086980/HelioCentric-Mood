import SwiftUI
import DesignSystem
import Core
import Data

struct QuotesView: View {
    @StateObject private var viewModel = QuotesViewModel()
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                QuotesHeader()
                
                // Wisdom for Today card
                WisdomForTodayCard(
                    quote: viewModel.todaysQuote,
                    onNewQuote: viewModel.loadRandomQuote
                )
                
                // Category grid
                CategoryGridView(
                    categories: viewModel.categories,
                    onCategoryTapped: viewModel.selectCategory
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 100) // Space for bottom toolbar
        }
        .background(EarthTheme.backgroundGradient)
        .onAppear {
            viewModel.loadData()
        }
        .sheet(isPresented: $viewModel.showQuoteList) {
            QuoteListView(
                category: viewModel.selectedCategory,
                quotes: viewModel.categoryQuotes,
                onQuoteTapped: viewModel.handleQuoteTap
            )
        }
    }
}

struct QuotesHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Wisdom")
                .font(.largeTitle.weight(.bold))
                .foregroundColor(EarthTheme.textPrimary)
            
            Text("Discover timeless wisdom and insights")
                .font(.subheadline)
                .foregroundColor(EarthTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct WisdomForTodayCard: View {
    let quote: Quote?
    let onNewQuote: () -> Void
    
    var body: some View {
        Card(style: .prominent) {
            VStack(spacing: 16) {
                HStack {
                    Text("Wisdom for Today")
                        .font(.headline.weight(.semibold))
                        .foregroundColor(EarthTheme.textPrimary)
                    
                    Spacer()
                    
                    Button("New Quote") {
                        onNewQuote()
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(EarthTheme.primary)
                }
                
                if let quote = quote {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(quote.text)
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(EarthTheme.textPrimary)
                            .multilineTextAlignment(.leading)
                        
                        HStack {
                            Text("— \(quote.displayAuthor)")
                                .font(.caption.weight(.medium))
                                .foregroundColor(EarthTheme.textSecondary)
                            
                            Spacer()
                            
                            TagChip(quote.categoryDisplayName) {}
                        }
                    }
                } else {
                    Text("Loading wisdom...")
                        .font(.subheadline)
                        .foregroundColor(EarthTheme.textSecondary)
                }
            }
        }
    }
}

struct CategoryGridView: View {
    let categories: [QuoteCategoryInfo]
    let onCategoryTapped: (QuoteCategory) -> Void
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Categories")
                .font(.headline.weight(.semibold))
                .foregroundColor(EarthTheme.textPrimary)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(categories, id: \.category) { categoryInfo in
                    CategoryCard(
                        category: categoryInfo.category,
                        count: categoryInfo.count,
                        onTap: { onCategoryTapped(categoryInfo.category) }
                    )
                }
            }
        }
    }
}

struct CategoryCard: View {
    let category: QuoteCategory
    let count: Int
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Card(style: .default) {
                VStack(spacing: 8) {
                    Text(category.displayName)
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(EarthTheme.textPrimary)
                    
                    Text("\(count) quotes")
                        .font(.caption.weight(.medium))
                        .foregroundColor(EarthTheme.textSecondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    QuotesView()
}
