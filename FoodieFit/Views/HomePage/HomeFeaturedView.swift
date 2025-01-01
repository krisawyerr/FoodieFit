//
//  HomeHeaderView.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class HomeFeaturedView: UIView {
    let databaseData = DatabaseData.shared
    
    private var collectionHeader: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        
        return stackview
    }()
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "FEATURED"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        
        return label
    }()
    private lazy var headerButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.bwOpposite, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(goToFullMenu), for: .touchUpInside)
        
        return button
    }()
    
    private var collection: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bwMain

        let gap = 10.0
        let itemWidth = 270.0
        let itemHeight = 350.0
        let headerHeight = 50.0
        let collectionHeight = headerHeight + itemHeight
        
        self.frame = CGRect(x: 0, y: 0, width: bounds.width, height: collectionHeight)
        
        addSubview(collectionHeader)
        NSLayoutConstraint.activate([
            collectionHeader.heightAnchor.constraint(equalToConstant: headerHeight),
            collectionHeader.widthAnchor.constraint(equalToConstant: bounds.width - 30),
            collectionHeader.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionHeader.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        collectionHeader.addArrangedSubview(headerLabel)
        collectionHeader.addArrangedSubview(headerButton)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = gap
        layout.scrollDirection = .horizontal
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(HomeFeaturedCell.self, forCellWithReuseIdentifier: "homeFeaturedCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        
        addSubview(collection)
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collection.topAnchor.constraint(equalTo: collectionHeader.bottomAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func goToFullMenu() {
        print("View Full Menu Pressed!")
    }
}

extension HomeFeaturedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(databaseData.featuredItems[indexPath.row].name) Clicked")
    }
}


extension HomeFeaturedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return databaseData.featuredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeFeaturedCell", for: indexPath) as! HomeFeaturedCell
        cell.setImageAndName(imgUrl: databaseData.featuredItems[indexPath.row].image_url, name: databaseData.featuredItems[indexPath.row].name, price: databaseData.featuredItems[indexPath.row].price)
        
        return cell
    }
}

#Preview {
    TabBarViewController()
}
