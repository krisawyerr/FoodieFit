//
//  ContactViewModel.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

import UIKit

class Contact {
    func triggerCall() {
        let phoneNumber = "1234567890"
        if let url = URL(string: "tel://\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Phone call not supported on this device")
            }
        }
    }
    
    func openEmail() {
        let email = "demo@foodiefit.com"
        if let url = URL(string: "mailto:\(email)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Email not supported on this device")
            }
        }
    }
}
