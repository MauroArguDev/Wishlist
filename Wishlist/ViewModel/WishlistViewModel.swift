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
    
    // MARK: - Public Methods
    func addWish(in context: ModelContext) {
        context.insert(Wish(title: title))
        title = ""
    }
    
    func delete(_ wish: Wish, in context: ModelContext) {
        context.delete(wish)
    }
}
