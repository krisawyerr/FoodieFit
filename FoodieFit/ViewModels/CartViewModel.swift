//
//  CartViewModel.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class Cart {
    static let shared = Cart()
    
    private init() {}
    
    var cartCount: Int = 0
    
    func addItems(numOfItems: Int, tabbar: UITabBarController) {
        self.cartCount += numOfItems
        updateCartTabIcon(tabbar: tabbar)
    }
    
    func removeItems(numOfItems: Int, tabbar: UITabBarController) {
        self.cartCount -= numOfItems
        updateCartTabIcon(tabbar: tabbar)
    }
    
    func updateCartTabIcon(tabbar: UITabBarController) {
        if let tabs = tabbar.tabBar.items, tabs.count == 4 {
            let cartTab = tabs[3]
            cartTab.badgeValue = cartCount > 0 ? "\(cartCount)" : ""
            cartTab.badgeColor = cartCount > 0 ? UIColor(named: "Accent") : UIColor.clear
        }
    }
}
