//
//  WishRow.swift
//  Wishlist
//
//  Created by Mauricio Argumedo on 30/9/25.
//

import SwiftUI

struct WishRow: View {
    // MARK: - Properties
    let wish: Wish
    let onDelete: () -> Void
    
    // MARK: - Body
    var body: some View {
        Text(wish.title)
            .font(.title2.weight(.light))
            .padding(.vertical, 2)
            .swipeActions {
                Button("Delete", role: .destructive) {
                    onDelete()
                }
            }
    }
}

#Preview {
    WishRow(wish: Wish(title: "")) { }
}
