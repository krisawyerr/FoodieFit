//
//  NavigationViewModel.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/1/25.
//

import UIKit

class Navigation {
    func goToProductsList(category: String, products: [Product], navigationController: UINavigationController) {
        let productsVC = MenuItemsViewController()
        
        productsVC.category = category
        productsVC.products = products
        
        navigationController.pushViewController(productsVC, animated: true)
    }
    
    func goToProducts(product: [Product], navigationController: UINavigationController) {
        let productVC = ItemViewController()
        
        productVC.product = product[0]
        
        navigationController.pushViewController(productVC, animated: true)
    }
}
