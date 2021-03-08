//
//  LoginViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/7/21.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var loginPresenterProtocol : IntroPresenterProtocol?

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loginPresenterProtocol = IntroPresenter(loginView: self)
        
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
    @IBAction func EmailTextFieldUpdate(_ sender: Any) {
        if self.EmailTextField.isFirstResponder {self.EmailTextField.backgroundColor = Constants.Colors.defaultColor}
        else {self.EmailTextField.becomeFirstResponder(); self.EmailTextField.backgroundColor = Constants.Colors.defaultColor}
    }
    @IBAction func PasswordTextFieldUpdate(_ sender: Any) {
        if self.PasswordTextField.isFirstResponder {self.EmailTextField.backgroundColor = Constants.Colors.defaultColor}
        else {self.PasswordTextField.becomeFirstResponder(); self.PasswordTextField.backgroundColor = Constants.Colors.defaultColor}
    }
    
    //---------------FIRST RESPONDER---------------
    
    //---------------VIEW CONNECTIONS--------------
    //This actions controls the flux between the intro views
    @IBAction func SignUpButton(_ sender: Any) {
        self.loginPresenterProtocol?.goTo(identifier: Constants.Segues.LoginToReg, from: self)
    }
    
    @IBAction func ForgotPasswordButton(_ sender: Any) {
        self.loginPresenterProtocol?.goTo(identifier: Constants.Segues.LoginToForgot, from: self)
    }
    
    //In this functions the values on the textFields are being checked ifEmpty to validate if we can proceed with the segue
    @IBAction func LoginButton(_ sender: Any) {
        var check = false
        if self.EmailTextField.text!.isEmpty {self.EmailTextField.backgroundColor = Constants.Colors.errorColor} else {check = true}
        if self.PasswordTextField.text!.isEmpty {self.PasswordTextField.backgroundColor = Constants.Colors.errorColor; check = false}
        //if check {self.loginPresenterProtocol?.doLogin()}
        if check {
            self.loginPresenterProtocol?.saveUser(email: self.EmailTextField.text!, password: self.PasswordTextField.text!)
            self.loginPresenterProtocol?.goTo(identifier: Constants.Segues.LoginToContacts, from: self)
            
        }
        
    }
    //---------------VIEW CONNECTIONS--------------
    
    
}
