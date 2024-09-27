//
//  FavoritesManager.swift
//  CocktailBook
//
//  Created by Hitesh Mor on 26/09/24.
//

import Foundation

protocol Favorites {
    func isFavorite(cocktail: Cocktail) -> Bool
    func toggleFavorite(cocktail: Cocktail)
}

class FavoritesManager: Favorites {
    private static let favoritesKey = "favorites"
    private(set) var favoriteCocktails: Set<String> = [] {
        didSet {
            saveFavorites()
        }
    }
    
    init() {
        loadFavorites()
    }
    
    func isFavorite(cocktail: Cocktail) -> Bool {
        favoriteCocktails.contains(cocktail.id)
    }
    
    func toggleFavorite(cocktail: Cocktail) {
        if isFavorite(cocktail: cocktail) {
            favoriteCocktails.remove(cocktail.id)
        } else {
            favoriteCocktails.insert(cocktail.id)
        }
    }
    
    private func saveFavorites() {
        let favoritesArray = Array(favoriteCocktails)
        let defaults = UserDefaults.standard
        let data = try? JSONEncoder().encode(favoritesArray)
        defaults.set(data, forKey: Self.favoritesKey)
    }
    
    private func loadFavorites() {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: Self.favoritesKey) {
            if let favoritesArray = try? JSONDecoder().decode([String].self, from: data) {
                favoriteCocktails = Set(favoritesArray)
            }
        }
    }
}


