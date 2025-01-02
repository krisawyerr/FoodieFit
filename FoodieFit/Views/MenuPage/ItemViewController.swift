//
//  MenuItemsViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/1/25.
//

import UIKit

class ItemViewController: UIViewController {
    var product: Product?
    
    private lazy var headerSection = CustomNavigationHeader(frame: view.bounds, navigationController: navigationController!, headerTitle: product!.name)
    private lazy var footerSection = ItemViewFooterView(frame: view.bounds, navigationController: navigationController!, product: product!, tabBarController: tabBarController!)
    
    private var mainBody: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BWMain")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    private var productImage: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false 
        imageview.contentMode = .scaleAspectFit
        
        return imageview
    }()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(headerSection)
        NSLayoutConstraint.activate([
            headerSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerSection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerSection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerSection.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(footerSection)
        NSLayoutConstraint.activate([
            footerSection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            footerSection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            footerSection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerSection.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        view.addSubview(mainBody)
        NSLayoutConstraint.activate([
            mainBody.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainBody.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainBody.topAnchor.constraint(equalTo: headerSection.bottomAnchor),
            mainBody.bottomAnchor.constraint(equalTo: footerSection.topAnchor)
        ])
        
        setImage()

        mainBody.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.leadingAnchor.constraint(equalTo: mainBody.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: mainBody.trailingAnchor),
            productImage.topAnchor.constraint(equalTo: mainBody.topAnchor),
            productImage.heightAnchor.constraint(equalTo: mainBody.widthAnchor)
        ])
        
    }
    func setImage() {
        guard let imageURLString = product?.image_url, let imageURL = URL(string: imageURLString) else { return }

        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.productImage.image = image
            }
        }
        task.resume()
    }
}
#Preview {
    TabBarViewController()
}
