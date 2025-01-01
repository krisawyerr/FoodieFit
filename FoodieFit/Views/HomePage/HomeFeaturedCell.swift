//
//  HomeFeaturedCell.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class HomeFeaturedCell: UICollectionViewCell {
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .unselected
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    private var textContainer: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        
        return stackview
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.heightAnchor.constraint(equalToConstant: bounds.width),
            productImage.widthAnchor.constraint(equalToConstant: bounds.width),
            productImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImage.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        contentView.addSubview(textContainer)
        NSLayoutConstraint.activate([
            textContainer.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10),
            textContainer.widthAnchor.constraint(equalTo: widthAnchor),
            textContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        textContainer.addArrangedSubview(nameLabel)
        textContainer.addArrangedSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageAndName(imgUrl: String, name: String, price: Float) {
        guard let url = URL(string: imgUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.productImage.image = image
            }
        }
        task.resume()
        
        let nameStyles = NSMutableAttributedString(
            string: name,
            attributes: [
                .foregroundColor: UIColor(named: "BWOpposite")!,
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
            ]
        )
        nameLabel.attributedText = nameStyles
        
        
        let priceStyles = NSMutableAttributedString(
            string: "$\(price)",
            attributes: [
                .foregroundColor: UIColor(named: "BWOpposite")!,
                .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
            ]
        )
        priceLabel.attributedText = priceStyles
        
    }
}

#Preview {
    TabBarViewController()
}
