//
//  Constants.swift
//  RxContacts
//
//  Created by user177273 on 3/6/21.
//

import Foundation
import UIKit

struct Constants {
    
    static let baseUrl = "https://contacts-bd.herokuapp.com/api/users/"
    
    struct Segues {
        static let LoginToForgot = "LoginToForgot"
        static let LoginToReg = "LoginToReg"
        static let LoginToContacts = "LoginToContacts"
        static let RegToLogin = "RegToLogin"
        static let RegToContacts = "RegToContacts"
        static let ForgotToLogin = "ForgotToLogin"
        static let ForgotToReg = "ForgotToReg"

    }
    
    struct Colors {
        static let errorColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        static let defaultColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        static let nameColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        static let lastNameColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.6)
    }
    
    struct Placeholders {
        static let empty = "You have to fill this field"
        static let passwordMatch = "Passwords don't match"
    }
    
    
}
