//
//  HistoryViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

import UIKit

class HistoryViewController: UIViewController {
    let navigate = Navigation()
    let formatter = Formatting()
    private lazy var headerSection = CustomNavigationHeader(frame: view.bounds, navigationController: navigationController!, headerTitle: "Past Orders", product: false)
    let databaseData = DatabaseData.shared
    private lazy var table: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "ordersCell")
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        table.reloadData()
    }
}
extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databaseData.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ordersCell", for: indexPath)
        
        cell.textLabel?.text = formatter.date(dateString: databaseData.orders.reversed()[indexPath.row].date)
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}
extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigator = navigationController else { return }
        
        navigate.goToOrderItemList(order: databaseData.orders.reversed()[indexPath.row], navigationController: navigator)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
#Preview {
    TabBarViewController()
}
