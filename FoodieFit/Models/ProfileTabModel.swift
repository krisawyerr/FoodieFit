//
//  ProfileTabModel.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

import UIKit

struct ProfileTab {
    var name: String
    var viewController: UIViewController?
}
struct ProfileSection {
    var name: String
    var tabs: [ProfileTab]
}
