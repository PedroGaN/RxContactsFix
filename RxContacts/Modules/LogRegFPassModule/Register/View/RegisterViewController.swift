//
//  RegisterViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/7/21.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var registerPresenterProtocol : IntroPresenterProtocol?

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.registerPresenterProtocol = IntroPresenter(registerView: self)
        
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
    @IBAction func ConfirmPasswordTextFieldUpdate(_ sender: Any) {
        if self.ConfirmPasswordTextField.isFirstResponder {self.ConfirmPasswordTextField.backgroundColor = Constants.Colors.defaultColor}
        else {self.ConfirmPasswordTextField.becomeFirstResponder(); self.ConfirmPasswordTextField.backgroundColor = Constants.Colors.defaultColor}
    }
    //---------------FIRST RESPONDER---------------
    
    //---------------VIEW CONNECTIONS--------------
    //This actions controls the flux between the intro views
    @IBAction func SignUpButton(_ sender: Any) {
        var check = false
        if self.EmailTextField.text!.isEmpty {self.EmailTextField.backgroundColor = Constants.Colors.errorColor} else {check = true}
        if self.PasswordTextField.text!.isEmpty {self.PasswordTextField.backgroundColor = Constants.Colors.errorColor; check = false}
        if self.PasswordTextField.text! != self.ConfirmPasswordTextField.text! {self.PasswordTextField.backgroundColor = Constants.Colors.errorColor; check = false}
        //if check {self.registerPresenterProtocol?.doRegister()}
        if check {self.registerPresenterProtocol?.goTo(identifier: Constants.Segues.RegToContacts, from: self)}
    }
    @IBAction func LoginButton(_ sender: Any) {
        self.registerPresenterProtocol?.goTo(identifier: Constants.Segues.RegToLogin, from: self)
    }
    //---------------VIEW CONNECTIONS--------------
}
