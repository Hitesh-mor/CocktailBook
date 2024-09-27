//
//  UIKitWrapperView.swift
//  Cocktail
//
//  Created by Hitesh Mor on 26/09/24.
//
import SwiftUI
import UIKit

struct UIKitWrapperView: UIViewControllerRepresentable {
    let controller: UIViewController
    let navigationController: UINavigationController

    func makeUIViewController(context: Context) -> UIViewController {
        navigationController.viewControllers = [controller]
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed
    }
}

