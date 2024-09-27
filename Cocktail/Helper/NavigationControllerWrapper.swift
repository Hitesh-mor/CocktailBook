//
//  NavigationControllerWrapper.swift
//  Cocktail
//
//  Created by Hitesh Mor on 27/09/24.
//
import SwiftUI
import UIKit

struct NavigationControllerWrapper: UIViewControllerRepresentable {
    @ObservedObject var coordinator: CocktailCoordinator

    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController()
        coordinator.navigationController = navigationController
        coordinator.showCocktailList()
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}

extension UINavigationController {
    // Remove back button 
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
