//
//  TabBarViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class TabBarViewController: UIViewController {
    public var tabbar: UITabBarController = {
        let tabbar = UITabBarController()
        tabbar.tabBar.backgroundColor = UIColor(named: "Background")
        tabbar.tabBar.tintColor = UIColor(named: "Selected")
        tabbar.tabBar.unselectedItemTintColor = UIColor(named: "Unselected")
        
        let homeVC = HomePageViewController()
        let homeTab = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeVC.tabBarItem = homeTab
        
        let menuVC = MenuPageViewController()
        let menuTab = UITabBarItem(title: "Menu", image: UIImage(systemName: "menucard"), selectedImage: UIImage(systemName: "menucard.fill"))
        menuVC.tabBarItem = menuTab
        
        let profileVC = ProfilePageViewController()
        let profileTab = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        profileVC.tabBarItem = profileTab
        
        let cartVC = CartPageViewController()
        let cartTab = UITabBarItem(title: "Cart", image: UIImage(systemName: "bag"), selectedImage: UIImage(systemName: "bag.fill"))
        cartVC.tabBarItem = cartTab
        cartVC.tabBarItem.badgeColor = .clear
        cartVC.tabBarItem.badgeValue = ""
        
        tabbar.setViewControllers([homeVC, menuVC, profileVC, cartVC], animated: false)
        return tabbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(tabbar)
        view.addSubview(tabbar.view)
        tabbar.didMove(toParent: self)
    }
}
#Preview {
    TabBarViewController()
}
