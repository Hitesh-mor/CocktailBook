//
//  CocktailViewModelTests.swift
//  CocktailTests
//
//  Created by Hitesh Mor on 26/09/24.
//
import XCTest
@testable import Cocktail

class CocktailViewModelTests: XCTestCase {
    var viewModel: CocktailViewModel!
    var mockFetchCocktailsUseCase: MockFetchCocktailsUseCase!
    var mockFavorites: Favorites!
    
    override func setUp() {
        super.setUp()
        mockFetchCocktailsUseCase = MockFetchCocktailsUseCase()
        mockFavorites = MockFavorites()
        viewModel = CocktailViewModel(
            fetchCocktailsUseCase: mockFetchCocktailsUseCase,
            favorites: mockFavorites
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockFetchCocktailsUseCase = nil
        mockFavorites = nil
        super.tearDown()
    }
    
    // Test initial state
    func testInitialState() {
        XCTAssertEqual(viewModel.filter, .all, "Initial filter should be .all")
        XCTAssertTrue(viewModel.filteredCocktails.isEmpty, "Initial cocktails list should be empty")
    }
    
    // Test loading cocktails
    func testLoadCocktails() {
        let expectation = self.expectation(description: "Cocktails should be loaded")
        
        viewModel.fetchCocktailsUseCase.execute { cocktails, error in
            if let cocktails = cocktails {
                self.viewModel.cocktails = cocktails
                self.viewModel.filterCocktails()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertEqual(self.viewModel.filteredCocktails.count, 2, "Cocktail list should contain two item")
            XCTAssertEqual(self.viewModel.filteredCocktails.first?.name, "Mojito", "Cocktail name should be Mojito")
        }
    }
    
    // Test sorting and favorites
    func testSorting() {
        let expectation = self.expectation(description: "Cocktails should be loaded")
        
        viewModel.fetchCocktailsUseCase.execute { cocktails, error in
            if let cocktails = cocktails {
                self.viewModel.cocktails = cocktails
                self.viewModel.filterCocktails()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertEqual(self.viewModel.filteredCocktails.first?.name, "Mojito", "Favorite cocktail should come first")
            XCTAssertEqual(self.viewModel.filteredCocktails.last?.name, "Old Fashioned", "Non-favorite cocktail should come last")
        }
    }
    
    // Test filter update
    func testUpdateFilter() {
        viewModel.filter = .alcoholic
        
        let expectation = self.expectation(description: "Cocktails should be loaded")
        
        viewModel.fetchCocktailsUseCase.execute { cocktails, error in
            if let cocktails = cocktails {
                self.viewModel.cocktails = cocktails
                self.viewModel.filterCocktails()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertEqual(self.viewModel.filter, .alcoholic, "Filter should be updated to .alcoholic")
            XCTAssertEqual(self.viewModel.filteredCocktails.first?.name, "Mojito", "Cocktail list should be updated based on filter")
            XCTAssertEqual(self.viewModel.filteredCocktails.count, 1, "Cocktail list should contain one item")
        }
    }
    
    // Test navigation title
    func testNavigationTitle() {
        XCTAssertEqual(viewModel.getNavigationTitle(), "All Cocktails", "Default navigation title should be 'All Cocktails'")
        
        viewModel.filter = .alcoholic
        
        XCTAssertEqual(viewModel.getNavigationTitle(), "Alcoholic Cocktails", "Navigation title should be 'Alcoholic Cocktails' after updating filter")
    }
}

// MARK: - Mocks

class MockFetchCocktailsUseCase: FetchCocktailsUseCase {
    var mockCocktails: [Cocktail] = [Cocktail(id: "1",
                                              name: "Mojito",
                                              type: .alcoholic,
                                              shortDescription: "A refreshing mint cocktail",
                                              longDescription: "A refreshing mint cocktail",
                                              preparationMinutes: 9,
                                              imageName: "",
                                              ingredients: []),
                                     Cocktail(id: "2",
                                              name: "Old Fashioned",
                                              type: .nonAlcoholic,
                                              shortDescription: "A refreshing mint cocktail",
                                              longDescription: "A refreshing mint cocktail",
                                              preparationMinutes: 9,
                                              imageName: "",
                                              ingredients: [])]
    
    func execute(completion: @escaping ([Cocktail]?, Error?) -> Void) {
        completion(mockCocktails, nil)
    }
}

class MockFavorites: Favorites {
    
    private var favoriteResult: [Cocktail] = []
    
    func isFavorite(cocktail: Cocktail) -> Bool {
        return favoriteResult.filter{ $0.id == cocktail.id }.count > 0
    }
    
    func toggleFavorite(cocktail: Cocktail) {
        if isFavorite(cocktail: cocktail) {
            favoriteResult = favoriteResult.filter { $0.id != cocktail.id }
        } else {
            favoriteResult.append(cocktail)
        }
    }
}
