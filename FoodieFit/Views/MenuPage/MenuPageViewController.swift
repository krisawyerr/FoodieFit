//
//  MenuPageViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit
import SDWebImage

class MenuPageViewController: UIViewController {
    let databaseData = DatabaseData.shared
    let navigate = Navigation()
    
    private var logo: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "Logo")
        
        return imageview
    }()
    private lazy var table: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "menuTableCell")
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorInset = .zero
        
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logo.heightAnchor.constraint(equalToConstant: 50),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
    }
}
extension MenuPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databaseData.categories.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableCell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.imageView?.image = UIImage(named: "AllProducts")
            cell.textLabel?.text = "View All"
        } else {
            let category = databaseData.categories[indexPath.row - 1]
            cell.textLabel?.text = category.name
            
            if let url = URL(string: category.image_url) {
                cell.imageView?.sd_setImage(with: url) { _, _, _, _ in
                    DispatchQueue.main.async {
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
extension MenuPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigator = navigationController else { return }
        
        navigate.goToProductsList(
            category: indexPath.row == 0 ? "All Products" : databaseData.categories[indexPath.row - 1].name,
            products: indexPath.row == 0 ? databaseData.items : databaseData.items.filter { $0.status.lowercased() == databaseData.categories[indexPath.row - 1].name.lowercased() },
            navigationController: navigator
        )
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
#Preview {
    TabBarViewController()
}
