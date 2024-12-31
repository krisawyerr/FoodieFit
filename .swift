////
////  HomePageViewController.swift
////  FoodieFit
////
////  Created by Kris Sawyerr on 12/31/24.
////
//
//import UIKit
//
//class HomePageViewController: UIViewController {
//    private var logo: UIImageView = {
//        let imageview = UIImageView()
//        imageview.translatesAutoresizingMaskIntoConstraints = false
//        imageview.contentMode = .scaleAspectFit
//        imageview.image = UIImage(named: "Logo")
//        
//        return imageview
//    }()
//    private var scrollview: UIScrollView = {
//        let view = UIScrollView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .white
//        view.showsVerticalScrollIndicator = false
//        view.isScrollEnabled = true
//       
//        return view
//    }()
//    private var stack: UIStackView = {
//        let view = UIStackView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.axis = .vertical
//        view.spacing = 10
//        view.alignment = .fill
//        view.distribution = .fill
//        
//        return view
//    }()
//    private var homeHeader: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .green
//        view.clipsToBounds = true
//        
//        return view
//    }()
//    private var homeHeaderImage: UIImageView = {
//        let imageview = UIImageView()
//        imageview.translatesAutoresizingMaskIntoConstraints = false
//        imageview.contentMode = .scaleAspectFill
//        imageview.image = UIImage(named: "HomeHeader")
//        
//        return imageview
//    }()
//    private var homeHeaderLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
//        
//        var styles = NSMutableAttributedString(
//            string: "Meal Prep\nMade Simple\nPerfect for all your health goals",
//            attributes: [
//                .foregroundColor: UIColor.white,
//                .font: UIFont.systemFont(ofSize: 19, weight: .heavy)
//            ]
//        )
//        styles.addAttribute(.font, value: UIFont.systemFont(ofSize: 45, weight: .heavy), range: NSRange(location: 0, length: 21))
//        label.attributedText = styles
//        
//        return label
//    }()
//    private var view2: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .cyan
//        
//        return view
//    }()
//    private var view3: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .purple
//        
//        return view
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(named: "Background")
//        
//        view.addSubview(logo)
//        NSLayoutConstraint.activate([
//            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            logo.heightAnchor.constraint(equalToConstant: 50),
//            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//        
//        view.addSubview(scrollview)
//        NSLayoutConstraint.activate([
//            scrollview.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
//            scrollview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            scrollview.widthAnchor.constraint(equalToConstant: view.bounds.width)
//        ])
//        
//        scrollview.addSubview(stack)
//        NSLayoutConstraint.activate([
//            stack.topAnchor.constraint(equalTo: scrollview.topAnchor),
//            stack.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: -10),
//            stack.widthAnchor.constraint(equalToConstant: view.bounds.width),
//        ])
//        
//        homeHeader.addSubview(homeHeaderImage)
//        NSLayoutConstraint.activate([
//            homeHeaderImage.widthAnchor.constraint(equalToConstant: view.bounds.width),
//            homeHeaderImage.topAnchor.constraint(equalTo: homeHeader.topAnchor),
//            homeHeaderImage.bottomAnchor.constraint(equalTo: homeHeader.bottomAnchor)
//        ])
//        homeHeader.addSubview(homeHeaderLabel)
//        NSLayoutConstraint.activate([
//            homeHeaderLabel.centerYAnchor.constraint(equalTo: homeHeader.centerYAnchor),
//            homeHeaderLabel.leadingAnchor.constraint(equalTo: homeHeader.leadingAnchor, constant: 15)
//        ])
//        
//        stack.addArrangedSubview(homeHeader)
//        stack.addArrangedSubview(view2)
//        stack.addArrangedSubview(view3)
//        
//        NSLayoutConstraint.activate([
//            homeHeader.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
//            view2.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
//            view3.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5)
//        ])
//    }
//}
//#Preview {
//    TabBarViewController()
//}
