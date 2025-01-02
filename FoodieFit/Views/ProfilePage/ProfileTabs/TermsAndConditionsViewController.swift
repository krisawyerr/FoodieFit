//
//  TermsAndConditionsViewController.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {
    var legalText = Legal()
    
    private lazy var headerSection = CustomNavigationHeader(frame: view.bounds, navigationController: navigationController!, headerTitle: "Terms and Conditions")
    private lazy var textview: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bwMain
        
        let styles = NSMutableAttributedString(
            string: legalText.termsAndConditions,
            attributes: [
                .font: UIFont.systemFont(ofSize: 20),
                .foregroundColor: UIColor(named: "BWOpposite")!
            ]
        )
        view.attributedText = styles
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        view.addSubview(headerSection)
        NSLayoutConstraint.activate([
            headerSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerSection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerSection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerSection.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(textview)
        NSLayoutConstraint.activate([
            textview.topAnchor.constraint(equalTo: headerSection.bottomAnchor),
            textview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
#Preview {
    UINavigationController(rootViewController: ProfilePageViewController())
}
