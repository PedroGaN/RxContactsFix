//
//  EditContactViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/20/21.
//

import Foundation
import UIKit

class EditContactViewController: UIViewController {
    
    var editContactPresenterProtocol : EditContactPresenterProtocol?
    
    var index : Int?
    
    @IBOutlet weak var ContactImageView: UIImageView!
    
    @IBOutlet weak var ContactNameTextField: UITextField!
    @IBOutlet weak var ContactLastNameTextField: UITextField!
    @IBOutlet weak var ContactEmailTextField: UITextField!
    @IBOutlet weak var ContactPhoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editContactPresenterProtocol = EditContactPresenter(editContactView: self)
        
        //-----------DISMISS KEYBOARD------------
        //We create a UITapGestureRecognizer calling the action  UIView.endEditing to dismiss the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(Constants.currentUser.contactsInfo[index ?? 0])
    }
    
    
    @IBAction func EditContactBTNAction(_ sender: Any) {
    }
    
    
}
