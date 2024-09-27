//
//  CocktailCoordinator.swift
//  Cocktail
//
//  Created by Hitesh Mor on 26/09/24.
//

//
//class CocktailCoordinator: ObservableObject {
//    @Published var selectedCocktail: Cocktail?
//
//    func showCocktailDetail(cocktail: Cocktail) {
//        self.selectedCocktail = cocktail
//    }
//
//    func resetSelection() {
//        self.selectedCocktail = nil
//    }
//}
import SwiftUI
import UIKit

class CocktailCoordinator: ObservableObject {
    var navigationController: UINavigationController
    let viewModel = DIContainer.shared.makeCocktailViewModel()
    @Published var selectedCocktail: Cocktail?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showCocktailList() {
        let cocktailListView = CocktailListView(viewModel: viewModel)
        navigationController.setViewControllers([UIHostingController(rootView: cocktailListView)], animated: false)
    }
    
    func showCocktailDetail(_ cocktail: Cocktail) {
        let detailViewModel = DIContainer.shared.makeCocktailDetailViewModel(cocktail: cocktail)
        let cocktailDetailView = CocktailDetailView(viewModel: detailViewModel)
        navigationController.pushViewController(UIHostingController(rootView: cocktailDetailView), animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
