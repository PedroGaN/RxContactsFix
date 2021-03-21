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
    
    let spinner = UIActivityIndicatorView(style: .large)
    
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
        if UserHelper.shared.checkUser() { self.loginPresenterProtocol?.goTo(identifier: Constants.Segues.LoginToContacts, from: self)}
    }
    
    @IBAction func SignInBTNAction(_ sender: Any) {
        var check = false
        var alertString = "Missing "
        if self.EmailTextField.text!.isEmpty {alertString += "| Email "} else {check = true}
        if self.PasswordTextField.text!.isEmpty {alertString += "| Password"; check = false}
        if check {
            
            self.startPetition()
            self.loginPresenterProtocol?.doLogin(email: self.EmailTextField.text!, password: PasswordTextField.text!, completion: { status in
                
                if status == "OK" {
                    
                    self.endPetition()
                    UserHelper.shared.saveUser()
                    self.loginPresenterProtocol?.goTo(identifier: Constants.Segues.LoginToContacts, from: self)
                }else{

                    self.endPetition()
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
    
    func startPetition(){
        self.view.addSubview(self.spinner)
        self.spinner.color = UIColor.blue
        self.spinner.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5)
        self.view.isUserInteractionEnabled = false
        self.view.alpha = 0.5
        self.spinner.startAnimating()
    }
    
    func endPetition(){
        self.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        self.view.alpha = 1
    }
}
