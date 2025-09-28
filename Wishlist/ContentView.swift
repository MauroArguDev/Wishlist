//
//  ContentView.swift
//  Wishlist
//
//  Created by Mauricio Argumedo on 27/9/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishList: [Wish]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishList) { wish in
                    Text(wish.title)
                }
            }
            .navigationTitle("Wish List")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
