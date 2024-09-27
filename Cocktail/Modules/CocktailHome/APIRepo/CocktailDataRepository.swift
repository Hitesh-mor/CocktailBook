//
//  CocktailDataRepository.swift
//  CocktailBook
//
//  Created by Hitesh Mor on 26/09/24.
//

import Foundation
import Combine

class CocktailDataRepository: CocktailRepository {
    
    private let cocktailsAPI: CocktailsAPI
    private var cancellable: [AnyCancellable] = []
    
    init(cocktailsAPI: CocktailsAPI = FakeCocktailsAPI()) {
        self.cocktailsAPI = cocktailsAPI
    }
    
    func getAllCocktails(completion: @escaping (_ cocktails: [Cocktail]?, _ error: Error?) -> Void) {
        cocktailsAPI.cocktailsPublisher
            .receive(on: DispatchQueue.main)
            .sink { status in
                switch status {
                case .failure( _):
                    debugPrint("Error in fetching Data")
                    
                case .finished:
                    debugPrint("Data fetched successfully")
                }
            } receiveValue: { data in
                do {
                    let cocktails = try JSONDecoder().decode([Cocktail].self, from: data)
                    completion(cocktails, nil)
                }
                catch {
                    completion(nil, error)
                }
            }.store(in: &cancellable)

    }
}

