//
//  HomeCategoryCell.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class HomeCategoryCell: UICollectionViewCell {
    private let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryImage)
        NSLayoutConstraint.activate([
            categoryImage.heightAnchor.constraint(equalToConstant: bounds.height * 0.75),
            categoryImage.widthAnchor.constraint(equalToConstant: bounds.height * 0.75),
            categoryImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryImage.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        contentView.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: categoryImage.bottomAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageAndName(imgUrl: String, name: String) {
        guard let url = URL(string: imgUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.categoryImage.image = image
            }
        }
        task.resume()
        
        let styles = NSMutableAttributedString(
            string: name.uppercased(),
            attributes: [
                .foregroundColor: UIColor(named: "BWOpposite")!,
                .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
            ]
        )
        categoryLabel.attributedText = styles
        
    }
}

#Preview {
    TabBarViewController()
}
