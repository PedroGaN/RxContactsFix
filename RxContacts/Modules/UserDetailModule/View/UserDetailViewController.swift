//
//  UserDetailViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController {
    
    var userDetailPresenterProtocol : UserDetailPresenterProtocol?
    
    @IBOutlet weak var userImageUIImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userDetailPresenterProtocol = UserDetailPresenter(userDetailView: self)
        
        self.userDetailPresenterProtocol?.setDetails()
        
    }
    
    
    @IBAction func ChangePasswordBtnAction(_ sender: Any) {
        if !self.newPasswordTextField.text!.isEmpty && !self.userPasswordTextField.text!.isEmpty {
            self.userDetailPresenterProtocol?.updatePassword(newPass: self.newPasswordTextField.text!, password: self.userPasswordTextField.text!)
        }
        
    }
    
    
}
