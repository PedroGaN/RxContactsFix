//
//  AddContactViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class AddContactViewController: UIViewController {
    
    var addContactPresenterProtocol : AddContactPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addContactPresenterProtocol = AddContactPresenter(addContactView: self)
        
    }
    
}
