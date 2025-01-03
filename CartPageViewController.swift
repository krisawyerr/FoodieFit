//
//  CartPageViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import UIKit

class CartPageViewController: UIViewController {
    let cart = Cart.shared
    private var logo: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "Logo")
        
        return imageview
    }()
    lazy var cartList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 115)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false 
        collection.dataSource = self
        collection.register(CartListCell.self, forCellWithReuseIdentifier: "cartListCell")
        
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logo.heightAnchor.constraint(equalToConstant: 50),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(cartList)
        NSLayoutConstraint.activate([
            cartList.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            cartList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cartList.reloadData()
    }
}
extension CartPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return /*cart.cartCount*/ 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartListCell", for: indexPath) as! CartListCell
        
        return cell
    }
}
class CartListCell: UICollectionViewCell {
    var quantity: Int?
    
    private lazy var addButton: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = UIColor(named: "BWOpposite")
        imageview.image = UIImage(systemName: "plus")

        imageview.isUserInteractionEnabled = true
        imageview.tag = 1
        var gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        imageview.addGestureRecognizer(gesture)
        
        return imageview
    }()
    private lazy var minusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 0
        
        var gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    private lazy var minusButton: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = UIColor(named: "BWOpposite")
        imageview.image = UIImage(systemName: "minus")
        let scaleTransform = CGAffineTransform(scaleX: 1, y: 1.2)
        imageview.transform = scaleTransform
        
        return imageview
    }()
    private var count: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "1"
        
        return label
    }()
    private var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "1st Step Pro-Wellness Liquid Multivitamin & Mineral"
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$99999.99"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .right
        
        return label
    }()
    private var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let styles = NSMutableAttributedString(
            string: "Remove",
            attributes: [
                .foregroundColor: UIColor(named: "Accent")!,
                .font: UIFont.systemFont(ofSize: 14),
                .underlineStyle: true,
            ]
        )
        button.setAttributedTitle(styles, for: .normal)
        
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.quantity = 1
        backgroundColor = .cyan
        
        addSubview(itemLabel)
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            itemLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            itemLabel.widthAnchor.constraint(equalToConstant: bounds.width * 0.7)
        ])
        
        addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
        
        addSubview(removeButton)
        NSLayoutConstraint.activate([
            removeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            removeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        ])
        
        addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
        addSubview(count)
        NSLayoutConstraint.activate([
            count.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            count.trailingAnchor.constraint(equalTo: addButton.leadingAnchor),
            count.widthAnchor.constraint(equalToConstant: 40)
        ])

        addSubview(minusView)
        NSLayoutConstraint.activate([
            minusView.widthAnchor.constraint(equalToConstant: 20),
            minusView.heightAnchor.constraint(equalToConstant: 20),
            minusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            minusView.trailingAnchor.constraint(equalTo: count.leadingAnchor),
        ])
        
        minusView.addSubview(minusButton)
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: 20),
            minusButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        print(1)
        guard let tag = sender.view?.tag, let quant = quantity else {
            print(3)
            return
        }
        
        if tag == 1 && quant < 20 {
            quantity! += 1
        } else if tag == 0 && quant > 1 {
            quantity! -= 1
        }

        count.text = "\(quantity!)"
        print(2)
    }
}
#Preview {
    CartPageViewController()
}
