//
//  ProfilePageViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class ProfilePageViewController: UIViewController {
    private var profileTabs: [ProfileSection] = [
        ProfileSection(name: "User Info", tabs: [
            ProfileTab(name: "Favorites", viewController: FavoritesViewController()),
            ProfileTab(name: "History", viewController: HistoryViewController()),
        ]),
        ProfileSection(name: "General Info", tabs: [
            ProfileTab(name: "Privacy", viewController: PrivacyViewController()),
            ProfileTab(name: "Terms and Conditions", viewController: TermsAndConditionsViewController()),
            ProfileTab(name: "Contact Us", viewController: ContactViewController()),
        ]),
    ]
    private var logo: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "Logo")
        
        return imageview
    }()
    private lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "profilePageCell")
        table.isScrollEnabled = false
        
        return table
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
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}
extension ProfilePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVC: UIViewController = profileTabs[indexPath.section].tabs[indexPath.row].viewController
        navigationController?.pushViewController(selectedVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
extension ProfilePageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileTabs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileTabs[section].tabs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profilePageCell", for: indexPath)
        
        cell.textLabel?.text = profileTabs[indexPath.section].tabs[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return profileTabs[section].name
    }
    
}
#Preview {
    UINavigationController(rootViewController: ProfilePageViewController())
}
