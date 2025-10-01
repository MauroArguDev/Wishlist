//
//  EmptyStateView.swift
//  Wishlist
//
//  Created by Mauricio Argumedo on 30/9/25.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "heart.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.red)

            Text("My Wishlist")
                .font(.title.weight(.semibold))

            Text("No items yet. Add some to get started.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding()
        .multilineTextAlignment(.center)
        .opacity(0.8)
    }
}

#Preview {
    EmptyStateView()
}
