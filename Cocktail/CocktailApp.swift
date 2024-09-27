//
//  CocktailApp.swift
//  Cocktail
//
//  Created by Hitesh Mor on 27/09/24.
//

import SwiftUI

@main
struct CocktailsApp: App {
    @StateObject private var coordinator = DIContainer.shared.makeCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationControllerWrapper(coordinator: coordinator)
                            .environmentObject(coordinator)
        }
    }
}

