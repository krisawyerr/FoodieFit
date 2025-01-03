//
//  ItemViewFooterView.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/1/25.
//

import UIKit

class ItemViewFooterView: UIView {
    let formatter = Formatting()
    var navigationController: UINavigationController?
    var tabBarController: UITabBarController?
    var product: Product?
    var cart = Cart.shared
    var quantity: Int = 1
    private var total: String {
        return formatter.price(number: Float(quantity) * product!.price)
    }
    
    private lazy var stepper = ItemStepper(
        frame: frame,
        quantity: quantity,
        addToCartButton: addToCartButton,
        product: product!,
        onQuantityChange: { [weak self] newQuantity in
            guard let self = self else { return }
            self.quantity = newQuantity
            self.addToCartButton.setTitle("Add To Cart: \(total)", for: .normal)
        }
    )
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add To Cart: \(total)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        button.backgroundColor = UIColor(named: "BWOpposite")
        button.setTitleColor(UIColor(named: "BWMain"), for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        return button
    }()
    
    init(frame: CGRect, navigationController: UINavigationController, product: Product, tabBarController: UITabBarController) {
        super.init(frame: frame)
        self.navigationController = navigationController
        self.product = product
        self.tabBarController = tabBarController
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stepper)
        NSLayoutConstraint.activate([
            stepper.leadingAnchor.constraint(equalTo: leadingAnchor),
            stepper.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            stepper.bottomAnchor.constraint(equalTo: bottomAnchor),
            stepper.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        addSubview(addToCartButton)
        NSLayoutConstraint.activate([
            addToCartButton.leadingAnchor.constraint(equalTo: stepper.trailingAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addToCart() {
        guard let tabbar = tabBarController, let name = product?.name, let price = product?.price else { return }
        
        print(quantity)
        cart.addItems(product: CartItem(name: name, price: price, quantity: quantity), tabbar: tabbar)
        
        navigationController?.popViewController(animated: true)
    }
}
#Preview {
    TabBarViewController()
}
