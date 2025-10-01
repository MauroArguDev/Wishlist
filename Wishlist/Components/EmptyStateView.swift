//
//  EmptyStateView.swift
//  Wishlist
//
//  Created by Mauricio Argumedo on 30/9/25.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ContentUnavailableView(
            "My Wishlist",
            systemImage: "heart.circle",
            description: Text(
                "No items yet. Add some to get started."
            )
        ).padding()
    }
}

#Preview {
    EmptyStateView()
}
