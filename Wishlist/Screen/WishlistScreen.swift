//
//  WishlistScreen.swift
//  Wishlist
//
//  Created by Mauricio Argumedo on 27/9/25.
//

import SwiftUI
import SwiftData

struct WishlistScreen: View {
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = WishlistViewModel()
    @Query private var wishList: [Wish]
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishList) { wish in
                    WishRow(wish: wish) {
                        viewModel.delete(wish, in: modelContext)
                    }
                }
            }
            .navigationTitle("Wishlist")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showNewWishAlert.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
            .alert("Create a new wish", isPresented: $viewModel.showNewWishAlert) {
                TextField("Enter your wish", text: $viewModel.title)
                Button("Save") {
                    viewModel.addWish(in: modelContext)
                }
            }
            .alert("Invalid Wish", isPresented: $viewModel.showEmptyTitleAlert) {
                Button("Accept", role: .cancel) {}
            } message: {
                Text("You cannot add a wish with an empty title.")
            }
            .overlay {
                if wishList.isEmpty {
                    EmptyStateView()
                }
            }
        }
    }
}

#Preview("Sample Data") {
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Wish(title: "Master SwiftData"))
    container.mainContext.insert(Wish(title: "Buy a new iPhone"))
    container.mainContext.insert(Wish(title: "Get Married"))
    container.mainContext.insert(Wish(title: "Live in Nederland"))
    
    return WishlistScreen()
        .modelContainer(container)
}

#Preview("Empty List") {
    WishlistScreen()
        .modelContainer(for: Wish.self, inMemory: true)
}
