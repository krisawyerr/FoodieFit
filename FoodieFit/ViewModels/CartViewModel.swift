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
    
    var cart: [CartItem] = []
    var cartTotal: Float {
        var total: Float = 0
        for item in cart {
            total += item.price * Float(item.quantity)
        }
        return total
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
    func incrementQuantity(product: CartItem) {
        let existingItemIndex = cart.firstIndex(where: { $0.name.lowercased() == product.name.lowercased() })!
        cart[existingItemIndex].quantity += 1
    }
    
    func removeItems(product: CartItem, tabbar: UITabBarController) {
        let existingItemIndex = cart.firstIndex(where: { $0.name.lowercased() == product.name.lowercased() })!
        cart.remove(at: existingItemIndex)
        
        updateCartTabIcon(tabbar: tabbar)
    }
    func decrementQuantity(product: CartItem) {
        let existingItemIndex = cart.firstIndex(where: { $0.name.lowercased() == product.name.lowercased() })!
        cart[existingItemIndex].quantity -= 1
    }
    
    func updateCartTabIcon(tabbar: UITabBarController) {
        if let tabs = tabbar.tabBar.items, tabs.count == 4 {
            let cartTab = tabs[3]
            cartTab.badgeValue = cart.count > 0 ? "\(cart.count)" : ""
            cartTab.badgeColor = cart.count > 0 ? UIColor(named: "Accent") : UIColor.clear
        }
    }
    func emptyCart(tabbar: UITabBarController) {
        cart = []
        updateCartTabIcon(tabbar: tabbar)
    }
}
