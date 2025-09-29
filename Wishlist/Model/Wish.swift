//
//  Wish.swift
//  Wishlist
//
//  Created by Mauricio Argumedo on 28/9/25.
//

import Foundation
import SwiftData

@Model
final class Wish: Identifiable {
    var id: UUID
    var title: String
    
    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}
