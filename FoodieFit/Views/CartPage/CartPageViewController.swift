//
//  CartPageViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class CartPageViewController: UIViewController {
    let databaseData = DatabaseData.shared
    let formatter = Formatting()
    let cart = Cart.shared
    private var logo: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "Logo")
        
        return imageview
    }()
    lazy var cartList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 115)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false 
        collection.dataSource = self
        collection.register(CartListCell.self, forCellWithReuseIdentifier: "cartListCell")
        collection.backgroundColor = UIColor(named: "Background")
        
        return collection
    }()
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout: \(formatter.price(number: cart.cartTotal))", for: .normal)
        button.setTitle("Cart Empty", for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        button.backgroundColor = UIColor(named: "BWOpposite")
        button.setTitleColor(UIColor(named: "BWMain"), for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkout), for: .touchUpInside)
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logo.heightAnchor.constraint(equalToConstant: 50),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(buyButton)
        NSLayoutConstraint.activate([
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            buyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(cartList)
        NSLayoutConstraint.activate([
            cartList.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            cartList.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -10),
            cartList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cartList.reloadData()
        buyButton.isEnabled = !cart.cart.isEmpty
        buyButton.setTitle("Checkout: \(formatter.price(number: cart.cartTotal))", for: .normal)
    }
    
    @objc func checkout() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        databaseData.addOrder(newOrder: Orders(
            items: cart.cart,
            total: cart.cartTotal,
            date: dateFormatter.string(from: Date()) 
        ))
        cart.emptyCart(tabbar: tabBarController!)
        tabBarController!.selectedIndex = 0
    }
}
extension CartPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cart.cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartListCell", for: indexPath) as! CartListCell
        cell.setUpCell(name: cart.cart[indexPath.row].name, product: cart.cart[indexPath.row], tabbarController: tabBarController!, cartList: cartList, buyButton: buyButton)
        
        return cell
    }
}
#Preview {
    TabBarViewController()
}
