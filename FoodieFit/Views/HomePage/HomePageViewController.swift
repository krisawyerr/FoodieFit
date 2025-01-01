//
//  HomePageViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class HomePageViewController: UIViewController {
    private var logo: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "Logo")
        
        return imageview
    }()
    private var scrollview: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bwMain
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = true
       
        return view
    }()
    private var stack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fill
        
        return view
    }()
    
    lazy var homeHeader = HomeHeaderView(frame: view.bounds)
    lazy var homeCatagories = HomeCategoryView(frame: view.bounds, navigationController: navigationController)
    lazy var homeFeatured = HomeFeaturedView(frame: view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logo.heightAnchor.constraint(equalToConstant: 50),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(scrollview)
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            scrollview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollview.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
        
        scrollview.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scrollview.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: -10),
            stack.widthAnchor.constraint(equalToConstant: view.bounds.width),
        ])
        
        stack.addArrangedSubview(homeHeader)
        stack.addArrangedSubview(homeCatagories)
        stack.addArrangedSubview(homeFeatured)
        
        NSLayoutConstraint.activate([
            homeHeader.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
            homeCatagories.heightAnchor.constraint(equalToConstant: homeCatagories.bounds.height),
            homeFeatured.heightAnchor.constraint(equalToConstant: homeFeatured.bounds.height)
        ])
    }
} 
#Preview {
    TabBarViewController()
}
