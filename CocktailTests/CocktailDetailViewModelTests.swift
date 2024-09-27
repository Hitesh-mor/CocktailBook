//
//  CocktailDetailViewModelTests.swift
//  CocktailTests
//
//  Created by Hitesh Mor on 26/09/24.
//

import XCTest
@testable import Cocktail

final class CocktailDetailViewModelTests: XCTestCase {

    var viewModel: CocktailDetailViewModel!
    var cocktail: Cocktail!
    var mockFavorites: Favorites!
    
    override func setUp() {
        super.setUp()
        mockFavorites = MockFavorites()
        cocktail = Cocktail(id: "1",
                            name: "Mojito",
                            type: .alcoholic,
                            shortDescription: "A refreshing mint cocktail",
                            longDescription: "A refreshing mint cocktail",
                            preparationMinutes: 9,
                            imageName: "",
                            ingredients: [])
        viewModel = CocktailDetailViewModel(
            cocktail: cocktail,
            favorites: mockFavorites
        )
    }
    
    override func tearDown() {
        cocktail = nil
        mockFavorites = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_toggleFavorites() {
        XCTAssertEqual(viewModel.isFavoritesCocktail(), false)

        XCTAssertEqual(viewModel.toggleFavorites(), true)
    }
}
