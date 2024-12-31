//
//  HomePageViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class HomePageViewController: UIViewController {
    let cart = Cart.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let tabbar = tabBarController {
            cart.addItems(numOfItems: 2, tabbar: tabbar)
        }
    }
}