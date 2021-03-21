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
    
 
    @IBOutlet weak var ContactImageView: UIImageView!
    @IBOutlet weak var ContactNameTextField: UITextField!
    @IBOutlet weak var ContactLastNameTextField: UITextField!
    @IBOutlet weak var ContactEmailTextField: UITextField!
    @IBOutlet weak var ContactPhoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addContactPresenterProtocol = AddContactPresenter(addContactView: self)
        
        //-----------DISMISS KEYBOARD------------
        //We create a UITapGestureRecognizer calling the action  UIView.endEditing to dismiss the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
    }
    
    
    @IBAction func AddContactButtonAction(_ sender: Any) {
    }
    
}
