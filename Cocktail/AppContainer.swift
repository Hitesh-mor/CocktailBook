//
//  AppContainer.swift
//  Cocktail
//
//  Created by Hitesh Mor on 26/09/24.
//

import Foundation
import UIKit

class DIContainer {
    static let shared = DIContainer()

    private let fetchCocktailsUseCase: FetchCocktailsUseCase
    private let favorites: Favorites

    private init() {
        self.fetchCocktailsUseCase = FetchCocktailsUseCaseImpl(repository: CocktailDataRepository())
        self.favorites = FavoritesManager()
    }

    func makeCocktailViewModel() -> CocktailViewModel {
        return CocktailViewModel(fetchCocktailsUseCase: fetchCocktailsUseCase, favorites: favorites)
    }

    func makeCoordinator() -> CocktailCoordinator {
        return CocktailCoordinator(navigationController: UINavigationController())
    }
    
    func makeCocktailDetailViewModel(cocktail: Cocktail) -> CocktailDetailViewModel {
        return CocktailDetailViewModel(cocktail: cocktail, favorites: favorites)
    }
}
