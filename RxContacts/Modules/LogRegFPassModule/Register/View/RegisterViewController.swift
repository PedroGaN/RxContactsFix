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
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
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
        print("entro")
        self.tryRegister(name: self.NameTextField.text!,
                         lastName: self.LastNameTextField.text!,
                         phone: self.PhoneNumberTextField.text!,
                         email: self.EmailTextField.text!,
                         password: self.PasswordTextField.text!,
                         checkPassword: self.ConfirmPasswordTextField.text!)
    }
    
    func tryRegister(name: String, lastName: String, phone: String, email: String, password: String, checkPassword: String){
        print("entro")
        var check = false
        var alertString = "Missing "
        if name.isEmpty {alertString += "| Name "} else {check = true}
        if lastName.isEmpty {alertString += "| LastName "; check = false}
        if phone.isEmpty {alertString += "| PhoneNumber "; check = false}
        if email.isEmpty {alertString += "| Email "; check = false}
        if password.isEmpty {alertString += "| Password "; check = false}
        if checkPassword.isEmpty {alertString += "| ConfirmPassword "; check = false}
        if check {
            if password != checkPassword {
                AlertHelper.shared.getAlert(alertText: "Passwords have to match", completion: { alert in
                    self.present(alert, animated: true, completion: nil)
                })
            } else {

                self.startPetition()
                self.registerPresenterProtocol?.doRegister(name: name, lastName: lastName, phone: phone, email: email, password: password, completion: { status in
                    if status == "OK" {
   
                        self.endPetition()
                        UserHelper.shared.saveUser()
                        self.registerPresenterProtocol?.goTo(identifier: Constants.Segues.RegToContacts, from: self)
                    }else{

                        self.endPetition()
                        AlertHelper.shared.getAlert(alertText: "Something went wrong", completion: { alert in
                            self.present(alert, animated: true, completion: nil)
                        })
                    }
                })
            }
        } else {
            AlertHelper.shared.getAlert(alertText: alertString, completion: { alert in
                self.present(alert, animated: true, completion: nil)
            })
        }
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
