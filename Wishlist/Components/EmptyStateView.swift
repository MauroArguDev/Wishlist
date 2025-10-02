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

            Text("my_wish")
                .font(.title.weight(.semibold))

            Text("no_items_yet")
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
