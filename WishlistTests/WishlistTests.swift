//
//  WishlistTests.swift
//  WishlistTests
//
//  Created by Mauricio Argumedo on 1/10/25.
//

import XCTest
import SwiftData
@testable import Wishlist

@MainActor
final class WishlistViewModelTests: XCTestCase {
    
    var viewModel: WishlistViewModel!
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    
    override func setUp() async throws {
        try await super.setUp()

        let schema = Schema([Wish.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: schema, configurations: [configuration])
        modelContext = ModelContext(modelContainer)
        
        viewModel = WishlistViewModel()
    }
    
    override func tearDown() async throws {
        viewModel = nil
        modelContext = nil
        modelContainer = nil
        try await super.tearDown()
    }
    
    // MARK: - addWish Tests
    
    func testAddWish_WithValidTitle_AddsWishToContext() throws {
        viewModel.title = "New iPhone"
        
        viewModel.addWish(in: modelContext)
        
        let wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 1)
        XCTAssertEqual(wishes.first?.title, "New iPhone")
        XCTAssertTrue(viewModel.title.isEmpty)
        XCTAssertFalse(viewModel.showEmptyTitleAlert)
    }
    
    func testAddWish_WithEmptyTitle_ShowsAlert() throws {
        viewModel.title = ""
        
        viewModel.addWish(in: modelContext)
        
        let wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 0)
        XCTAssertTrue(viewModel.showEmptyTitleAlert)
    }
    
    func testAddWish_WithWhitespaceTitle_ShowsAlert() throws {
        viewModel.title = "   "
        
        viewModel.addWish(in: modelContext)
        
        let wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 0)
        XCTAssertTrue(viewModel.showEmptyTitleAlert)
    }
    
    func testAddWish_WithTitleContainingWhitespace_TrimsWhitespace() throws {
        viewModel.title = "  MacBook Pro  "
        
        viewModel.addWish(in: modelContext)
        
        let wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 1)
        XCTAssertEqual(wishes.first?.title, "MacBook Pro")
    }
    
    func testAddWish_ClearsTitleAfterSuccessfulAdd() throws {
        viewModel.title = "iPad"
        
        viewModel.addWish(in: modelContext)
        
        XCTAssertTrue(viewModel.title.isEmpty)
    }
    
    func testAddWish_MultipleWishes_AddsAllToContext() throws {
        viewModel.title = "First Wish"
        viewModel.addWish(in: modelContext)
        
        viewModel.title = "Second Wish"
        viewModel.addWish(in: modelContext)
        
        viewModel.title = "Third Wish"
        viewModel.addWish(in: modelContext)
        
        let wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 3)
    }
    
    // MARK: - Delete Tests
    
    func testDelete_RemovesWishFromContext() throws {
        let wish = Wish(title: "Test Wish")
        modelContext.insert(wish)
        
        var wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 1)
        
        viewModel.delete(wish, in: modelContext)
        
        wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 0)
    }
    
    func testDelete_WithMultipleWishes_RemovesOnlySpecifiedWish() throws {
        let wish1 = Wish(title: "Keep This")
        let wish2 = Wish(title: "Delete This")
        let wish3 = Wish(title: "Keep This Too")
        
        modelContext.insert(wish1)
        modelContext.insert(wish2)
        modelContext.insert(wish3)
        
        viewModel.delete(wish2, in: modelContext)
        
        let wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 2)
        XCTAssertTrue(wishes.contains(where: { $0.id == wish1.id }))
        XCTAssertTrue(wishes.contains(where: { $0.id == wish3.id }))
        XCTAssertFalse(wishes.contains(where: { $0.id == wish2.id }))
    }
}

// MARK: - Wish Model Tests

final class WishModelTests: XCTestCase {
    
    func testWish_InitializesWithDefaultID() {
        let wish = Wish(title: "Test Wish")
        
        XCTAssertNotNil(wish.id)
        XCTAssertEqual(wish.title, "Test Wish")
    }
    
    func testWish_InitializesWithCustomID() {
        let customID = UUID()
        
        let wish = Wish(id: customID, title: "Custom ID Wish")
        
        XCTAssertEqual(wish.id, customID)
        XCTAssertEqual(wish.title, "Custom ID Wish")
    }
    
    func testWish_DifferentInstancesHaveDifferentIDs() {
        let wish1 = Wish(title: "First")
        let wish2 = Wish(title: "Second")
        
        XCTAssertNotEqual(wish1.id, wish2.id)
    }
}

// MARK: - Integration Tests

@MainActor
final class WishlistIntegrationTests: XCTestCase {
    
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    var viewModel: WishlistViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        
        let schema = Schema([Wish.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: schema, configurations: [configuration])
        modelContext = ModelContext(modelContainer)
        viewModel = WishlistViewModel()
    }
    
    override func tearDown() async throws {
        viewModel = nil
        modelContext = nil
        modelContainer = nil
        try await super.tearDown()
    }
    
    func testCompleteWorkflow_AddAndDeleteWish() throws {
        viewModel.title = "Test Workflow"
        
        viewModel.addWish(in: modelContext)
        var wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        
        XCTAssertEqual(wishes.count, 1)
        let addedWish = wishes.first!
        
        viewModel.delete(addedWish, in: modelContext)
        wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        
        XCTAssertEqual(wishes.count, 0)
    }
    
    func testCompleteWorkflow_AddMultipleDeleteOne() throws {
        let titles = ["Wish 1", "Wish 2", "Wish 3"]
        for title in titles {
            viewModel.title = title
            viewModel.addWish(in: modelContext)
        }
        
        var wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 3)
        
        let wishToDelete = wishes[1]
        viewModel.delete(wishToDelete, in: modelContext)
        
        wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 2)
    }
    
    func testErrorHandling_InvalidWishDoesNotAffectValidWishes() throws {
        viewModel.title = "Valid Wish"
        viewModel.addWish(in: modelContext)
        
        viewModel.title = ""
        viewModel.addWish(in: modelContext)
        
        let wishes = try modelContext.fetch(FetchDescriptor<Wish>())
        XCTAssertEqual(wishes.count, 1)
        XCTAssertEqual(wishes.first?.title, "Valid Wish")
        XCTAssertTrue(viewModel.showEmptyTitleAlert)
    }
}
