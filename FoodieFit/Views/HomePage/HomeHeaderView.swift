//
//  HomeHeaderView.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

private var homeHeaderImage: UIImageView = {
    let imageview = UIImageView()
    imageview.translatesAutoresizingMaskIntoConstraints = false
    imageview.contentMode = .scaleAspectFill
    imageview.image = UIImage(named: "HomeHeader")
    
    return imageview
}()
private var homeHeaderLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    
    var styles = NSMutableAttributedString(
        string: "Meal Prep\nMade Simple\nPerfect for all your health goals",
        attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 19, weight: .heavy)
        ]
    )
    styles.addAttribute(.font, value: UIFont.systemFont(ofSize: 45, weight: .heavy), range: NSRange(location: 0, length: 21))
    label.attributedText = styles
    
    return label
}()

class HomeHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        addSubview(homeHeaderImage)
        NSLayoutConstraint.activate([
            homeHeaderImage.widthAnchor.constraint(equalToConstant: bounds.width),
            homeHeaderImage.topAnchor.constraint(equalTo: topAnchor),
            homeHeaderImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        addSubview(homeHeaderLabel)
        NSLayoutConstraint.activate([
            homeHeaderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            homeHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
