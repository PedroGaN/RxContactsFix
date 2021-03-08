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
        
        //-----------DISMISS KEYBOARD------------
        //We create a UITapGestureRecognizer calling the action  UIView.endEditing to dismiss the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
        
    }
    
    //---------------FIRST RESPONDER---------------
    //This two actions controls the flux of FirstResponders by checking if the sender is the first responder or not
    //and assigning the value that corresponds at that moment also returns the background color to default color

    @IBAction func NewPasswordTextFieldUpdate(_ sender: Any) {
        if self.newPasswordTextField.isFirstResponder {self.newPasswordTextField.backgroundColor = Constants.Colors.defaultColor}
        else {self.newPasswordTextField.becomeFirstResponder(); self.newPasswordTextField.backgroundColor = Constants.Colors.defaultColor}
    }
    @IBAction func PasswordTextFieldUpdate(_ sender: Any) {
        if self.userPasswordTextField.isFirstResponder {self.userPasswordTextField.backgroundColor = Constants.Colors.defaultColor}
        else {self.userPasswordTextField.becomeFirstResponder(); self.userPasswordTextField.backgroundColor = Constants.Colors.defaultColor}
    }
    //---------------FIRST RESPONDER---------------
    
    
    //In this functions the values on the textFields are being checked ifEmpty to validate if we can proceed with the action
    @IBAction func ChangePasswordBtnAction(_ sender: Any) {
        var check = false
        if self.newPasswordTextField.text!.isEmpty {self.newPasswordTextField.backgroundColor = Constants.Colors.errorColor} else {check = true}
        if self.userPasswordTextField.text!.isEmpty {self.userPasswordTextField.backgroundColor = Constants.Colors.errorColor; check = false}
        //if check {self.loginPresenterProtocol?.doLogin()}
        if check {
            self.userDetailPresenterProtocol?.updatePassword(newPass: self.newPasswordTextField.text!, password: self.userPasswordTextField.text!)
        }
    }
    @IBAction func DeleteBtnAction(_ sender: Any) {
        if !self.userPasswordTextField.text!.isEmpty {
            self.userDetailPresenterProtocol?.deleteUser(password: self.userPasswordTextField.text!)
        }
    }
    
    
}
