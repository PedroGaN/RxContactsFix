//
//  AddContactPresenter.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit
import Alamofire

class AddContactPresenter: AddContactPresenterProtocol {
    
    var addContactView : AddContactViewController

    init (addContactView: AddContactViewController){
        self.addContactView = addContactView
    }
    
    func clearFields() {
        self.addContactView.ContactEmailTextField.text = ""
        self.addContactView.ContactNameTextField.text = ""
        self.addContactView.ContactLastNameTextField.text = ""
        self.addContactView.ContactPhoneNumberTextField.text = ""
    }
    
    func addContact(name: String, lastName: String, email: String, phoneNumber: Int, completion: @escaping (String) -> Void) {
        let contact = ContactsInfo(name: name, lastName: lastName, email: email, phoneNumber: phoneNumber)
        //let contact = ContactsInfo(name: name, lastName: lastName, email: email, contactImage: "" ,phoneNumber: phoneNumber)
        
        Constants.currentUser.contactsInfo.append(contact)
        
        let encodedContacts = try? JSONEncoder().encode(Constants.currentUser.contactsInfo)
        
        let encodedContactsString = String(data: encodedContacts!, encoding: String.Encoding.utf8)
        
        print(encodedContacts ?? "NO CODIFICADO")
        
        let headers : HTTPHeaders = [ "Authorization" : "Bearer " + Constants.currentUser.apiToken]
        let parameters : [String : Any] =
            [
                "id" : Constants.currentUser.id,
                "password" : "",
                "name" : Constants.currentUser.name,
                "last_name" : Constants.currentUser.lastName,
                "email" : Constants.currentUser.email,
                "contacts_info" : encodedContactsString ?? ""
            ]

        
        NetworkManager.shared.update(parameters: parameters, headers: headers, completion: { status in
            completion(status)
        })
        
        UserHelper.shared.saveUser()
        self.clearFields()
    }
    
}

protocol AddContactPresenterProtocol{
    func addContact(name: String, lastName: String, email: String, phoneNumber: Int, completion: @escaping (String) -> Void)
}
