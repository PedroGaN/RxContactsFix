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
    
    init (addContactView: AddContactViewController){
        self.addContactView = addContactView
    }
    
}

protocol AddContactPresenterProtocol{
    
}
