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
    
    
    @IBAction func SignUpBTNAction(_ sender: Any) {
        var check = false
        var alertString = "Missing "
        if self.EmailTextField.text!.isEmpty {alertString += "| Email "} else {check = true}
        if self.PasswordTextField.text!.isEmpty {alertString += "| Password "; check = false}
        if self.ConfirmPasswordTextField.text!.isEmpty {alertString += "| ConfirmPassword"; check = false}
        if check {
            if self.PasswordTextField.text! != self.ConfirmPasswordTextField.text! {
                AlertHelper.shared.getAlert(alertText: "Passwords have to match", completion: { alert in
                    self.present(alert, animated: true, completion: nil)
                })
            } else {self.registerPresenterProtocol?.goTo(identifier: Constants.Segues.RegToContacts, from: self)}
            
            
        }else {AlertHelper.shared.getAlert(alertText: alertString, completion: { alert in
            self.present(alert, animated: true, completion: nil)
        })}
    }
    
    
    
    
    //---------------VIEW CONNECTIONS--------------
    //This actions controls the flux between the intro views
    /*@IBAction func SignUpButton(_ sender: Any) {
        var check = false
        if self.EmailTextField.text!.isEmpty {self.EmailTextField.backgroundColor = Constants.Colors.errorColor} else {check = true}
        if self.PasswordTextField.text!.isEmpty {self.PasswordTextField.backgroundColor = Constants.Colors.errorColor; check = false}
        if self.PasswordTextField.text! != self.ConfirmPasswordTextField.text! {self.PasswordTextField.backgroundColor = Constants.Colors.errorColor; check = false}
        //if check {self.registerPresenterProtocol?.doRegister()}
        if check {self.registerPresenterProtocol?.goTo(identifier: Constants.Segues.RegToContacts, from: self)}
    }
    @IBAction func LoginButton(_ sender: Any) {
        self.registerPresenterProtocol?.goTo(identifier: Constants.Segues.RegToLogin, from: self)
    }*/
    //---------------VIEW CONNECTIONS--------------
}
