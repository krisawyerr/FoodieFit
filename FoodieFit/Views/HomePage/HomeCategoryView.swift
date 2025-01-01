//
//  HomeHeaderView.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class HomeCategoryView: UIView {
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
        label.text = "MENU"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        
        return label
    }()
    private lazy var headerButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Full Menu", for: .normal)
        button.setTitleColor(.bwOpposite, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(goToFullMenu), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bwMain

        let collectionWidth = bounds.width - 20
        let numOfColumns = 3.0
        let gap = 1.0
        let itemWidth = (collectionWidth - (numOfColumns - 1) * gap) / numOfColumns
        let itemHeigth = itemWidth
        let numOfItems = 6.0
        let numOfRows = numOfItems / numOfColumns
        let headerHeight = 50.0
        let collectionHeight = (numOfRows * itemHeigth) + ((numOfRows - 1) + gap + headerHeight)
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
        layout.itemSize = CGSize(width: itemWidth, height: itemHeigth)
        layout.minimumInteritemSpacing = gap
        layout.minimumLineSpacing = gap
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(HomeCategoryCell.self, forCellWithReuseIdentifier: "homeCategoryCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = false
        
        addSubview(collection)
        NSLayoutConstraint.activate([
            collection.widthAnchor.constraint(equalToConstant: collectionWidth),
            collection.centerXAnchor.constraint(equalTo: centerXAnchor),
            collection.topAnchor.constraint(equalTo: collectionHeader.bottomAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") 
    }
    
    @objc func goToFullMenu() {
        print("View Full Menu Pressed!")
    }
    
}
extension HomeCategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(databaseData.categories[indexPath.row].name) Clicked")
    }
}
extension HomeCategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return databaseData.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoryCell", for: indexPath) as! HomeCategoryCell
        cell.setImageAndName(imgUrl: databaseData.categories[indexPath.row].image_url, name: databaseData.categories[indexPath.row].name)
        
        return cell
    }
}

#Preview {
    TabBarViewController()
}
