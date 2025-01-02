//
//  ItemViewHeaderView.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/1/25.
//

import UIKit

class ItemViewHeaderView: UIView {
    var navigationController: UINavigationController?
    var product: Product?
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.text = product?.name.uppercased()
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "BWOpposite")
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    
    init(frame: CGRect, navigationController: UINavigationController, product: Product) {
        super.init(frame: frame)
        self.navigationController = navigationController
        self.product = product
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65)
        ])
        
        addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
}
