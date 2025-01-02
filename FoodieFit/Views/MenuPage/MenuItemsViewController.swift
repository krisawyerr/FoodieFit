//
//  MenuItemsViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/1/25.
//

import UIKit

class MenuItemsViewController: UIViewController {
    var category: String?
    var products: [Product]?
    var navigate = Navigation()
    private lazy var filteredProducts: [Product]? = products
    
    private var headerSection: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    private lazy var searchbar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .minimal
        bar.delegate = self
        
        return bar
    }()
    private var logo: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "Logo")
        
        return imageview
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "BWOpposite")
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
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
        
        view.addSubview(headerSection)
        NSLayoutConstraint.activate([
            headerSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerSection.heightAnchor.constraint(equalToConstant: 50),
            headerSection.widthAnchor.constraint(equalToConstant: view.bounds.width),
            headerSection.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        headerSection.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logo.heightAnchor.constraint(equalToConstant: 50),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: view.bounds.width - 130)
        ])
        headerSection.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.centerYAnchor.constraint(equalTo: headerSection.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: headerSection.leadingAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 15)
        ])
        
        view.addSubview(searchbar)
        NSLayoutConstraint.activate([
            searchbar.topAnchor.constraint(equalTo: headerSection.bottomAnchor),
            searchbar.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
        
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: searchbar.bottomAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
extension MenuItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableCell", for: indexPath)
        
        cell.textLabel?.text = filteredProducts?[indexPath.row].name
        cell.textLabel?.numberOfLines = 0
        
        if let urlString = filteredProducts?[indexPath.row].image_url, let url = URL(string: urlString) {
            cell.imageView?.sd_setImage(with: url) { _, _, _, _ in
                DispatchQueue.main.async {
                    cell.setNeedsLayout()
                }
            }
        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
extension MenuItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
        
        guard let navigator = navigationController else { return }
        
        navigate.goToProducts(
            product: [products![indexPath.row]],
            navigationController: navigator
        )
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension MenuItemsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products?.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        table.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
    }
}
#Preview {
    TabBarViewController()
}
