//
//  HomeHeaderView.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class HomeFeaturedView: UIView {
    let databaseData = DatabaseData.shared
    let navigate = Navigation()
    var navigationController: UINavigationController?
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FEATURED"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        
        return label
    }()
    
    private var collection: UICollectionView!
    
    init(frame: CGRect, navigationController: UINavigationController?) {
        self.navigationController = navigationController
        super.init(frame: frame)
        backgroundColor = .bwMain
        
        let gap = 10.0
        let itemWidth = 270.0
        let itemHeight = 350.0
        let headerHeight = 50.0
        let collectionHeight = headerHeight + itemHeight
        
        self.frame = CGRect(x: 0, y: 0, width: bounds.width, height: collectionHeight)
        
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.heightAnchor.constraint(equalToConstant: headerHeight),
            headerLabel.widthAnchor.constraint(equalToConstant: bounds.width - 30),
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
        
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
            collection.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeFeaturedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(databaseData.featuredItems[indexPath.row].name) Clicked")
        guard let navigator = navigationController else { return }
        
        navigate.goToProducts(
            product: databaseData.items.filter { $0.name.lowercased() == databaseData.featuredItems[indexPath.row].name.lowercased() },
            navigationController: navigator
        )
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
