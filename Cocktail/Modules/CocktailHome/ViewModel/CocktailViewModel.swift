//
//  CocktailViewModel.swift
//  Cocktail
//
//  Created by Hitesh Mor on 26/09/24.
//

import Combine
import Foundation

class CocktailViewModel: ObservableObject {
    var cocktails: [Cocktail]?
    
    @Published var filter: CocktailFilter = .all
    @Published var filteredCocktails: [Cocktail] = []
    @Published var isLoading: Bool = false
    
    let favorites: Favorites
    let fetchCocktailsUseCase: FetchCocktailsUseCase
    
    init(fetchCocktailsUseCase: FetchCocktailsUseCase, favorites: Favorites) {
        self.fetchCocktailsUseCase = fetchCocktailsUseCase
        self.favorites = favorites
    }

    func loadCocktails() {
        if (cocktails == nil) {
            self.isLoading = true
            fetchCocktailsUseCase.execute() { [weak self] cocktails, _ in
                DispatchQueue.main.async {
                    self?.cocktails = cocktails ?? []
                    self?.filterCocktails()
                    self?.isLoading = false
                }
            }
        } else {
            filterCocktails()
        }
    }
    
    func filterCocktails() {
        if let cocktail = cocktails {
            let sortedCocktail = cocktail.sorted { $0.name < $1.name }
            switch filter {
            case .all:
                filteredCocktails = getSortedCocktails(sortedCocktail: sortedCocktail)
            case .alcoholic:
                filteredCocktails = getSortedCocktails(sortedCocktail: sortedCocktail.filter { $0.type == TypeEnum.alcoholic })
            case .nonAlcoholic:
                filteredCocktails = getSortedCocktails(sortedCocktail: sortedCocktail.filter { $0.type == TypeEnum.nonAlcoholic })
            }
        }
    }

    func getNavigationTitle() -> String {
        switch filter {
        case .all: return Constants.Navigation.allCocktails
        case .alcoholic: return Constants.Navigation.alcoholicCocktails
        case .nonAlcoholic: return Constants.Navigation.nonAlcoholicCocktails
        }
    }
    
    private func getSortedCocktails(sortedCocktail: [Cocktail]) -> [Cocktail] {
        return sortedCocktail.sorted { (first, second) -> Bool in
            let isFirstFavorite = favorites.isFavorite(cocktail: first)
            let isSecondFavorite = favorites.isFavorite(cocktail: second)
            
            if isFirstFavorite == isSecondFavorite {
                return first.name < second.name
            }
            return isFirstFavorite && !isSecondFavorite
        }
    }
}
