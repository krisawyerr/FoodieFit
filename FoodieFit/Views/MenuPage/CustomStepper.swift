//
//  CustomStepper.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/1/25.
//

import UIKit

class CustomStepper: UIView {
    var product: Product?
    var quantity: Int?
    var addToCartButton: UIButton?
    private var total: String {
        return String(format: "%.2f", Float(quantity ?? 1) * product!.price)
    }
    
    private lazy var addButton: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = UIColor(named: "BWOpposite")
        imageview.image = UIImage(systemName: "plus")

        imageview.isUserInteractionEnabled = true
        imageview.tag = 1
        var gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        imageview.addGestureRecognizer(gesture)
        
        return imageview
    }()
    private lazy var minusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 0
        
        var gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
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
        label.text = "1"
        
        return label
    }()
    
    init(frame: CGRect, quantity: Int, addToCartButton: UIButton, product: Product) {
        super.init(frame: frame)
        self.quantity = quantity
        self.addToCartButton = addToCartButton
        self.product = product
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(count)
        NSLayoutConstraint.activate([
            count.centerYAnchor.constraint(equalTo: centerYAnchor),
            count.centerXAnchor.constraint(equalTo: centerXAnchor),
            count.widthAnchor.constraint(equalToConstant: 40)
        ])

        addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 20),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            addButton.leadingAnchor.constraint(equalTo: count.trailingAnchor, constant: 10),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        addSubview(minusView)
        NSLayoutConstraint.activate([
            minusView.widthAnchor.constraint(equalToConstant: 20),
            minusView.heightAnchor.constraint(equalToConstant: 20),
            minusView.trailingAnchor.constraint(equalTo: count.leadingAnchor, constant: -10),
            minusView.centerYAnchor.constraint(equalTo: centerYAnchor)
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
    
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag, let quant = quantity else { return }
        
        if tag == 1 && quant < 20 {
            quantity! += 1
        } else if tag == 0 && quant > 1 {
            quantity! -= 1
        }
        
        addToCartButton!.setTitle("Add To Cart: $\(total)", for: .normal)
        count.text = "\(quantity!)"
    }
}
