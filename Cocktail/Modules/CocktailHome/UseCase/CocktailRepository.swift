//
//  CocktailRepository.swift
//  CocktailBook
//
//  Created by Hitesh Mor on 26/09/24.
//

import Foundation

protocol CocktailRepository {
    func getAllCocktails(completion: @escaping (_ cocktails: [Cocktail]?, _ error: Error?) -> Void)
}
