import SwiftUI
import DesignSystem
import Core
import Data

struct QuoteListView: View {
    let category: QuoteCategory?
    let quotes: [Quote]
    let onQuoteTapped: (Quote) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(quotes) { quote in
                        QuoteCard(
                            quote: quote,
                            onTap: { onQuoteTapped(quote) }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .background(EarthTheme.backgroundGradient)
            .navigationTitle(category?.displayName ?? "Quotes")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct QuoteCard: View {
    let quote: Quote
    let onTap: (Quote) -> Void
    
    var body: some View {
        Button(action: { onTap(quote) }) {
            Card(style: .default) {
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
                        
                        if quote.isFavorite {
                            Image(systemName: "heart.fill")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    QuoteListView(
        category: .wisdom,
        quotes: [
            Quote(text: "Wisdom begins in wonder.", author: "Socrates", category: "Wisdom"),
            Quote(text: "The unexamined life is not worth living.", author: "Socrates", category: "Wisdom")
        ],
        onQuoteTapped: { _ in }
    )
}
