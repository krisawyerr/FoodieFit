//
//  FavoritesViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

import UIKit

class FavoritesViewController: UIViewController {
    private lazy var headerSection = CustomNavigationHeader(frame: view.bounds, navigationController: navigationController!, headerTitle: "Favorite Products", product: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        view.addSubview(headerSection)
        NSLayoutConstraint.activate([
            headerSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerSection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerSection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerSection.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
#Preview {
    UINavigationController(rootViewController: ProfilePageViewController())
}
