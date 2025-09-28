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
    @State private var showNewWishAlert = false
    @State private var title = ""
    
    @Query private var wishList: [Wish]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishList) { wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                }
            }
            .navigationTitle("Wishlist")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewWishAlert.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
            .alert("Create a new wish", isPresented: $showNewWishAlert) {
                TextField("Enter your wish", text: $title)
                
                Button {
                    
                } label : {
                    Text("Save")
                }
            }
            .overlay {
                if wishList.isEmpty {
                    ContentUnavailableView("My Wishlist", systemImage: "heart.circle", description: Text("No items yet. Add some to get started."))
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
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
