//
//  Wish.swift
//  Wishlist
//
//  Created by Mauricio Argumedo on 28/9/25.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
