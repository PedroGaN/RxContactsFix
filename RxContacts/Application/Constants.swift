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
    
    static var currentUser : User = User(id: 0, name: "", lastName: "", email: "", phoneNumber: 0, userImage: "", contactsInfo: [], apiToken: "", createdAt: "", updatedAt: "")
    
    struct Segues {

        static let LoginToContacts = "LoginToContacts"
        static let RegToContacts = "RegisterToContacts"
        static let ContactToEdit = "ContactToEdit"
        static let ContactToNew = "ContactToNew"

    }
    
    
}
