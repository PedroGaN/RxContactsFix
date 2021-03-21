//
//  ContactsPresenter.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class ContactsPresenter: ContactsPresenterProtocol {
    
    var contactsView : ContactsViewController?
    
    init (contactsView: ContactsViewController){
        self.contactsView = contactsView
    }
    
    func goTo(identifier: String, from: UIViewController) {
        from.performSegue(withIdentifier: identifier, sender: Any?.self)
    }
    
    func searchByName(search: String) -> Contacts {
        
        var searchedContacts : Contacts = []
        
        for contact in Constants.currentUser.contactsInfo {
            if contact.name.contains(search) || contact.lastName.contains(search){
                searchedContacts.append(contact)
            }
        }
        
        return searchedContacts
    }
    
    func searchByEmail(search: String) -> Contacts {
        
        var searchedContacts : Contacts = []
        
        for contact in Constants.currentUser.contactsInfo {
            if contact.email.contains(search) {
                searchedContacts.append(contact)
            }
        }
        
        return searchedContacts
    }
    
    func searchByPhone(search: String) -> Contacts {
        
        var searchedContacts : Contacts = []
        
        for contact in Constants.currentUser.contactsInfo {
            if String(contact.phoneNumber).contains(search){
                searchedContacts.append(contact)
            }
        }
        
        return searchedContacts
    }
}

protocol ContactsPresenterProtocol{
    func goTo(identifier: String, from: UIViewController)
    func searchByName(search: String) -> Contacts
    func searchByEmail(search: String) -> Contacts
    func searchByPhone(search: String) -> Contacts
}
