//
//  AddContactPresenter.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class AddContactPresenter: AddContactPresenterProtocol {
    
    var addContactView : AddContactViewController
    
    var currentUser : User?
    
    init (addContactView: AddContactViewController){
        self.addContactView = addContactView
    }
    
    func clearFields() {
        self.addContactView.ContactEmailTextField.text = ""
        self.addContactView.ContactNameTextField.text = ""
        self.addContactView.ContactLastNameTextField.text = ""
        self.addContactView.ContactPhoneNumberTextField.text = ""
    }
    
    func addContact(name: String, lastName: String, email: String, phoneNumber: Int) {
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
