//
//  OrderItemCell.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

import UIKit

class OrderItemCell: UICollectionViewCell {
    let formatter = Formatting()
    private var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Turkey Rancheros Breakfast Burrito"
        
        return label
    }()
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .right
        label.text = "$6.99 x 3"
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .bwMain
        
        addSubview(itemLabel)
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            itemLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            itemLabel.widthAnchor.constraint(equalToConstant: bounds.width * 0.5)
        ])
        
        addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(cartItem: CartItem?, total: Float, isTotal: Bool) {
        guard let item = cartItem else {
            priceLabel.text = formatter.price(number: total)
            itemLabel.text = "Total:"
            return
        }
        
        priceLabel.text = "$\(item.price) x \(item.quantity)"
        itemLabel.text = item.name
    }
}
