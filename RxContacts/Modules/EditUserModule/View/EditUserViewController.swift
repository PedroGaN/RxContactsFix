//
//  EditUserViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/20/21.
//

import Foundation
import UIKit

class EditUserViewController: UIViewController {
    
    var editUserPresenterProtocol : EditUserPresenterProtocol?
    
    @IBOutlet weak var UserImageView: UIImageView!
    
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var UserLastNameTextField: UITextField!
    @IBOutlet weak var UserPhoneNumberTextField: UITextField!
    @IBOutlet weak var UserEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editUserPresenterProtocol = EditUserPresenter(editUserView: self)
        
        
        //-----------DISMISS KEYBOARD------------
        //We create a UITapGestureRecognizer calling the action  UIView.endEditing to dismiss the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
        
    }
    
    @IBAction func EditUserBTNAction(_ sender: Any) {
    }
    
}
