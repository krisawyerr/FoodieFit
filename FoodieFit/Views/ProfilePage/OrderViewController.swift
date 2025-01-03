//
//  OrderViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

import UIKit

class OrderViewController: UIViewController {
    var order: Orders?
    let formatter = Formatting()
    private lazy var headerSection = CustomNavigationHeader(frame: view.bounds, navigationController: navigationController!, headerTitle: formatter.date(dateString: order!.date), product: false)
    let databaseData = DatabaseData.shared
    private lazy var table: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 50)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(OrderItemCell.self, forCellWithReuseIdentifier: "orderCell")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        view.addSubview(headerSection)
        NSLayoutConstraint.activate([
            headerSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerSection.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: headerSection.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension OrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return order!.items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath) as! OrderItemCell
        
        if indexPath.row == order!.items.count {
            cell.setUpCell(cartItem: nil, total: order!.total, isTotal: true)
        } else {
            cell.setUpCell(cartItem: order!.items[indexPath.row], total: order!.total, isTotal: false)
        }
        
        return cell
    }
}

#Preview {
    TabBarViewController()
}
