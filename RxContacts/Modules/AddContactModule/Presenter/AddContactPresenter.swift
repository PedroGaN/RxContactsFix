//
//  AddContactPresenter.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class AddContactPresenter: AddContactPresenterProtocol {
    
    var addContactView : AddContactViewController?
    
    var currentUser : User?
    
    init (addContactView: AddContactViewController){
        self.addContactView = addContactView
    }
    
    func getUser() {
        let savedUser : Data = NetworkManager.shared.defaults.object(forKey: "saved_user") as! Data
        if let decodedUser = try? JSONDecoder().decode(User.self, from: savedUser){
            self.currentUser = decodedUser
        }
    }
    
    func clearFields() {
        self.addContactView?.EmailContactTextField.text = ""
        self.addContactView?.NameContactTextField.text = ""
        self.addContactView?.LastNameContactTextField.text = ""
        self.addContactView?.PhoneNumberContactTextField.text = ""
    }
    
    func addContact(name: String, lastName: String, email: String, phoneNumber: Int) {
        self.getUser()
        let contact = ContactsInfo(name: name, lastName: lastName, email: email, phoneNumber: phoneNumber)
        self.currentUser?.contactsInfo.append(contact)
        let encodedUser = try? JSONEncoder().encode(self.currentUser)
        NetworkManager.shared.defaults.setValue(encodedUser, forKey: "saved_user")
        self.clearFields()
    }
    
}

protocol AddContactPresenterProtocol{
    func addContact(name: String, lastName: String, email: String, phoneNumber: Int)
}
