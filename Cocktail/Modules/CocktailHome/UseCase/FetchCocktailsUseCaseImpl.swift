//
//  FetchCocktailsUseCaseImpl.swift
//  CocktailBook
//
//  Created by Hitesh Mor on 26/09/24.
//

import Foundation

struct Cocktail: Codable {
    let id, name: String
    let type: TypeEnum
    let shortDescription, longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    var isFavorite: Bool?
}

enum TypeEnum: String, Codable {
    case alcoholic = "alcoholic"
    case nonAlcoholic = "non-alcoholic"
}

enum CocktailFilter {
    case all, alcoholic, nonAlcoholic
}

protocol FetchCocktailsUseCase {
    func execute(completion: @escaping (_ cocktails: [Cocktail]?, _ error: Error?) -> Void)
}

class FetchCocktailsUseCaseImpl: FetchCocktailsUseCase {
    private let repository: CocktailRepository

    init(repository: CocktailRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (_ cocktails: [Cocktail]?, _ error: Error?) -> Void) {
        repository.getAllCocktails(completion: { cocktails, error in
            
            return completion(cocktails, error)
        })
    }
}
