//
//  CartViewModel.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

struct CartItem {
    var name: String
    var price: Float
    var quantity: Int
}

class Cart {
    static let shared = Cart()
    
    private init() {}
    
    var cart: [CartItem] = []
    var cartCount: Int {
        return cart.count
    }
    
    func addItems(product: CartItem, tabbar: UITabBarController) {
        guard cart.filter({ $0.name.lowercased() == product.name.lowercased() }).isEmpty else {
            let existingItemIndex = cart.firstIndex(where: { $0.name.lowercased() == product.name.lowercased() })!
            cart[existingItemIndex].quantity += product.quantity
            
            return
        }
        
        self.cart.append(product)
        updateCartTabIcon(tabbar: tabbar)
    }
    
    func removeItems(numOfItems: Int, tabbar: UITabBarController) {
        
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
