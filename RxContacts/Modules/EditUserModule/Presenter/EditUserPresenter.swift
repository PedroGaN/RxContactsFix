//
//  EditUserPresenter.swift
//  RxContacts
//
//  Created by user177273 on 3/20/21.
//

import Foundation
import UIKit

class EditUserPresenter: EditUserPresenterProtocol {
    
    var editUserView : EditUserViewController
    
    init (editUserView: EditUserViewController){
        self.editUserView = editUserView
    }
       
    func editUser(password: String) {

    }
    
}

protocol EditUserPresenterProtocol{
    func editUser(password: String)
}
