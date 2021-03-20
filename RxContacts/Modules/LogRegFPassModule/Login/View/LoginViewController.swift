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
    
    override func viewDidAppear(_ animated: Bool) {
        /*if self.loginPresenterProtocol?.checkUser() ?? false {
            self.loginPresenterProtocol?.goTo(identifier: Constants.Segues.LoginToContacts, from: self)
        }*/
        
    }
    
    //---------------VIEW CONNECTIONS--------------
    //This actions controls the flux between the intro views
    
    @IBAction func SignInBTNAction(_ sender: Any) {
        var check = false
        var alertString = "Missing "
        if self.EmailTextField.text!.isEmpty {alertString += "| Email "} else {check = true}
        if self.PasswordTextField.text!.isEmpty {alertString += "| Password"; check = false}
        if check {
            
            self.loginPresenterProtocol?.doLogin(email: self.EmailTextField.text!, password: PasswordTextField.text!, completion: { status in
                
                if status == "OK" {
                    self.loginPresenterProtocol?.goTo(identifier: Constants.Segues.LoginToContacts, from: self)
                }else{
                    AlertHelper.shared.getAlert(alertText: "Something went wrong", completion: { alert in
                        self.present(alert, animated: true, completion: nil)
                    })
                }
                
            })
        }
        else {AlertHelper.shared.getAlert(alertText: alertString, completion: { alert in
            self.present(alert, animated: true, completion: nil)
        })}
    }
    
    @IBAction func ForgotPasswordBTNAction(_ sender: Any) {
        AlertHelper.shared.getRecoverPasswordAlert(completion: { alert in
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    /*
    @IBAction func ForgotPasswordButton(_ sender: Any) {
        self.loginPresenterProtocol?.goTo(identifier: Constants.Segues.LoginToForgot, from: self)
    }
    
    //In this functions the values on the textFields are being checked ifEmpty to validate if we can proceed with the segue
    @IBAction func LoginButton(_ sender: Any) {
        /*var check = false
        if self.LoginEmailTextField.text!.isEmpty {self.LoginEmailTextField.backgroundColor = Constants.Colors.errorColor} else {check = true}
        if self.LoginPasswordTextField.text!.isEmpty {self.LoginPasswordTextField.backgroundColor = Constants.Colors.errorColor; check = false}
        //if check {self.loginPresenterProtocol?.doLogin()}
        if check {
            self.loginPresenterProtocol?.saveUser(email: self.LoginEmailTextField.text!, password: self.LoginPasswordTextField.text!)
            self.loginPresenterProtocol?.goTo(identifier: Constants.Segues.LoginToContacts, from: self)
            
        }*/
        
    }
    //---------------VIEW CONNECTIONS--------------*/
    
    
}
