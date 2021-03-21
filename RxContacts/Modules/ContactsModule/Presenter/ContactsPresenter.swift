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
}

protocol ContactsPresenterProtocol{
    func goTo(identifier: String, from: UIViewController)
}
