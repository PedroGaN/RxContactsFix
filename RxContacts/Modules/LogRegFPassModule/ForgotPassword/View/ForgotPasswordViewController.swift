//
//  ForgotPasswordViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/7/21.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    var forgotPasswordPresenterProtocol : IntroPresenterProtocol?

    @IBOutlet weak var EmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.forgotPasswordPresenterProtocol = IntroPresenter(forgotPasswordView: self)
        
        //-----------DISMISS KEYBOARD------------
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
        
    }

    //---------------DELETE ERROR COLOR------------
    //This action returns to default color the background color of the EmailTextField
    @IBAction func EmailTextFieldUpdate(_ sender: Any) {
        self.EmailTextField.backgroundColor = Constants.Colors.defaultColor
    }
    //---------------DELETE ERROR COLOR------------
    //---------------VIEW CONNECTIONS--------------
    //This actions controls the flux between the intro views
    @IBAction func LoginButton(_ sender: Any) {
        self.forgotPasswordPresenterProtocol?.goTo(identifier: Constants.Segues.ForgotToLogin, from: self)
    }
    @IBAction func SignUpButton(_ sender: Any) {
        self.forgotPasswordPresenterProtocol?.goTo(identifier: Constants.Segues.ForgotToReg, from: self)
    }
    @IBAction func RecoverPasswordButton(_ sender: Any) {
        if self.EmailTextField.text!.isEmpty{self.EmailTextField.backgroundColor = Constants.Colors.errorColor}
        else{self.forgotPasswordPresenterProtocol?.doRememberPassword()}
    }
    //---------------VIEW CONNECTIONS--------------
    
}
