//
//  WishlistApp.swift
//  Wishlist
//
//  Created by Mauricio Argumedo on 27/9/25.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
