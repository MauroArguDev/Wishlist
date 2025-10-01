//
//  WishlistViewModel.swift
//  Wishlist
//
//  Created by Mauricio Argumedo on 30/9/25.
//

import Foundation
import Combine
import SwiftData

@MainActor
final class WishlistViewModel: ObservableObject {
    // MARK: - Properties
    @Published var title = ""
    @Published var showNewWishAlert = false
    @Published var showEmptyTitleAlert = false
    
    // MARK: - Public Methods
    func addWish(in context: ModelContext) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else {
            showEmptyTitleAlert = true
            return
        }
        context.insert(Wish(title: trimmedTitle))
        title = ""
    }
    
    func delete(_ wish: Wish, in context: ModelContext) {
        context.delete(wish)
    }
}
