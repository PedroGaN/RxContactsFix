//
//  ContactsPresenter.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation

class ContactsPresenter: ContactsPresenterProtocol {
    
    var contactsView : ContactsViewController?
    
    init (contactsView: ContactsViewController){
        self.contactsView = contactsView
    }
    
    func getUser() {
        let savedUser : Data = NetworkManager.shared.defaults.object(forKey: "saved_user") as! Data
        if let decodedUser = try? JSONDecoder().decode(User.self, from: savedUser){
            self.contactsView?.currentUser = decodedUser
        }
    }
}

protocol ContactsPresenterProtocol{
    func getUser()
}
