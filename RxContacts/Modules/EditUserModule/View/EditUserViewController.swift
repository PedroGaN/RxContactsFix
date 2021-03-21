//
//  EditUserViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/20/21.
//

import Foundation
import UIKit

class EditUserViewController: UIViewController {
    
    var editUserPresenterProtocol : EditUserPresenterProtocol?
    
    @IBOutlet weak var UserImageView: UIImageView!
    
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var UserLastNameTextField: UITextField!
    @IBOutlet weak var UserPhoneNumberTextField: UITextField!
    @IBOutlet weak var UserEmailTextField: UITextField!
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editUserPresenterProtocol = EditUserPresenter(editUserView: self)
        
        
        //-----------DISMISS KEYBOARD------------
        //We create a UITapGestureRecognizer calling the action  UIView.endEditing to dismiss the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
        
    }
    
    @IBAction func EditUserBTNAction(_ sender: Any) {
        self.tryUpdate(name: self.UserNameTextField.text!, lastName: self.UserLastNameTextField.text!, phone: self.UserPhoneNumberTextField.text!, email: self.UserEmailTextField.text!)
    }
    
    func tryUpdate(name: String, lastName: String, phone: String, email: String){
        var check = false
        var alertString = "Missing "
        if name.isEmpty {alertString += "| Name "} else {check = true}
        if lastName.isEmpty {alertString += "| LastName "; check = false}
        if phone.isEmpty {alertString += "| PhoneNumber "; check = false}
        if email.isEmpty {alertString += "| Email "; check = false}
        if check {
            AlertHelper.shared.getUpdateUserAlert(view: self, completion: {alert in
                self.present(alert, animated: true, completion: nil)
            })
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
    
    func clearFields() {
        self.UserNameTextField.text = ""
        self.UserLastNameTextField.text = ""
        self.UserEmailTextField.text = ""
        self.UserPhoneNumberTextField.text = ""
    }
    
}
