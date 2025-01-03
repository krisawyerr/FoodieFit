//
//  CartListCell.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

import UIKit

class CartListCell: UICollectionViewCell {
    let formatter = Formatting()
    let cart = Cart.shared
    var quantity: Int?
    var price: Float?
    var product: CartItem?
    var tabbarController: UITabBarController?
    var cartList: UICollectionView?
    var buyButton: UIButton?
    
    private lazy var addButton: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = UIColor(named: "BWOpposite")
        imageview.image = UIImage(systemName: "plus")

        imageview.isUserInteractionEnabled = true
        imageview.tag = 1
        var gesture = UITapGestureRecognizer(target: self, action: #selector(stepperButtonTapped(_:)))
        imageview.addGestureRecognizer(gesture)
        
        return imageview
    }()
    private lazy var minusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 0
        
        var gesture = UITapGestureRecognizer(target: self, action: #selector(stepperButtonTapped(_:)))
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    private lazy var minusButton: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = UIColor(named: "BWOpposite")
        imageview.image = UIImage(systemName: "minus")
        let scaleTransform = CGAffineTransform(scaleX: 1, y: 1.2)
        imageview.transform = scaleTransform
        
        return imageview
    }()
    private var count: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    private var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .right
        
        return label
    }()
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(removeFromCart), for: .touchUpInside)
        
        let styles = NSMutableAttributedString(
            string: "Remove",
            attributes: [
                .foregroundColor: UIColor(named: "Accent")!,
                .font: UIFont.systemFont(ofSize: 14),
                .underlineStyle: true,
            ]
        )
        button.setAttributedTitle(styles, for: .normal)
        
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .bwMain
        
        addSubview(itemLabel)
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            itemLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            itemLabel.widthAnchor.constraint(equalToConstant: bounds.width * 0.7)
        ])
        
        addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
        
        addSubview(removeButton)
        NSLayoutConstraint.activate([
            removeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            removeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        ])
        
        addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
        addSubview(count)
        NSLayoutConstraint.activate([
            count.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            count.trailingAnchor.constraint(equalTo: addButton.leadingAnchor),
            count.widthAnchor.constraint(equalToConstant: 40)
        ])

        addSubview(minusView)
        NSLayoutConstraint.activate([
            minusView.widthAnchor.constraint(equalToConstant: 20),
            minusView.heightAnchor.constraint(equalToConstant: 20),
            minusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            minusView.trailingAnchor.constraint(equalTo: count.leadingAnchor),
        ])
        
        minusView.addSubview(minusButton)
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: 20),
            minusButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(name: String, product: CartItem, tabbarController: UITabBarController, cartList: UICollectionView, buyButton: UIButton) {
        self.product = product
        self.quantity = product.quantity
        count.text = "\(product.quantity)"
        self.price = product.price
        priceLabel.text = formatter.price(number: product.price * Float(product.quantity))
        itemLabel.text = name
        self.tabbarController = tabbarController
        self.cartList = cartList
        self.buyButton = buyButton
    }
    
    @objc func stepperButtonTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag, let quant = quantity else { return }
        
        if tag == 1 && quant < 20 {
            cart.incrementQuantity(product: product!)
            quantity! += 1
        } else if tag == 0 && quant > 1 {
            cart.decrementQuantity(product: product!)
            quantity! -= 1
        }

        buyButton!.setTitle("Checkout: \(formatter.price(number: cart.cartTotal))", for: .normal)
        count.text = "\(quantity!)"
        priceLabel.text = formatter.price(number: price! * Float(quantity!))
        print(cart.cartTotal)
    }
    @objc func removeFromCart() {
        cart.removeItems(product: product!, tabbar: tabbarController!)
        cartList?.reloadData()
        buyButton!.setTitle("Checkout: \(formatter.price(number: cart.cartTotal))", for: .normal)
        buyButton!.isEnabled = !cart.cart.isEmpty
    }
}
