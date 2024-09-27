//
//  CocktailDetailViewModel.swift
//  Cocktail
//
//  Created by Hitesh Mor on 26/09/24.
//

import Foundation

class CocktailDetailViewModel: ObservableObject {
    let cocktail: Cocktail
    let favorites: Favorites
    
    init(cocktail: Cocktail, favorites: Favorites) {
        self.cocktail = cocktail
        self.favorites = favorites
    }
    
    func toggleFavorites() -> Bool {
        self.favorites.toggleFavorite(cocktail: cocktail)
        return isFavoritesCocktail()
    }
    
    func isFavoritesCocktail() -> Bool {
        return favorites.isFavorite(cocktail: cocktail)
    }
}
