//
//  CustomNavigationHeader.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/1/25.
//

import UIKit

class CustomNavigationHeader: UIView {
    let databaseData = DatabaseData.shared
    var navigationController: UINavigationController?
    var headerTitle: String?
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.text = headerTitle?.uppercased()
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
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .accent
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.addTarget(self, action: #selector(favoritePressed), for: .touchUpInside)
        
        return button
    }()
    
    init(frame: CGRect, navigationController: UINavigationController, headerTitle: String, product: Bool) {
        super.init(frame: frame)
        self.navigationController = navigationController
        self.headerTitle = headerTitle
        
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
        
        if product {
            addSubview(favoriteButton)
            setDefaultFavoriteValue()
            
            NSLayoutConstraint.activate([
                favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                favoriteButton.widthAnchor.constraint(equalToConstant: 20),
                favoriteButton.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
    }
    func setDefaultFavoriteValue() {
        let isFavorited = databaseData.favoriteItems.contains(where: { $0.name.lowercased() == headerTitle?.lowercased()})
        favoriteButton.isSelected = isFavorited
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    @objc func favoritePressed() {
        if favoriteButton.isSelected {
            databaseData.removeFavoriteItem(item: headerTitle!)
        } else {
            databaseData.addFavoriteItem(item: headerTitle!)
        }
        
        favoriteButton.isSelected = !favoriteButton.isSelected
    }
    
}
#Preview {
    TabBarViewController()
}
