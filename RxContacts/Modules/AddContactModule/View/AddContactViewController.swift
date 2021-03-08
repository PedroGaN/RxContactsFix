//
//  AddContactViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class AddContactViewController: UIViewController {
    
    var addContactPresenterProtocol : AddContactPresenterProtocol?
    
    @IBOutlet weak var NameContactTextField: UITextField!
    @IBOutlet weak var LastNameContactTextField: UITextField!
    @IBOutlet weak var EmailContactTextField: UITextField!
    @IBOutlet weak var PhoneNumberContactTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addContactPresenterProtocol = AddContactPresenter(addContactView: self)
        
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
    @IBAction func NameContactTextFieldUpdate(_ sender: Any) {
        if self.NameContactTextField.isFirstResponder {self.NameContactTextField.backgroundColor = Constants.Colors.defaultColor}
        else {self.NameContactTextField.becomeFirstResponder(); self.NameContactTextField.backgroundColor = Constants.Colors.defaultColor}
    }
    @IBAction func LastNameContactTextFieldUpdate(_ sender: Any) {
        if self.LastNameContactTextField.isFirstResponder {self.LastNameContactTextField.backgroundColor = Constants.Colors.defaultColor}
        else {self.LastNameContactTextField.becomeFirstResponder(); self.LastNameContactTextField.backgroundColor = Constants.Colors.defaultColor}
    }
    @IBAction func EmailContactTextFieldUpdate(_ sender: Any) {
        if self.EmailContactTextField.isFirstResponder {self.EmailContactTextField.backgroundColor = Constants.Colors.defaultColor}
        else {self.EmailContactTextField.becomeFirstResponder(); self.EmailContactTextField.backgroundColor = Constants.Colors.defaultColor}
    }
    @IBAction func PhoneNumberContactTextFieldUpdate(_ sender: Any) {
        if self.PhoneNumberContactTextField.isFirstResponder {self.PhoneNumberContactTextField.backgroundColor = Constants.Colors.defaultColor}
        else {self.PhoneNumberContactTextField.becomeFirstResponder(); self.PhoneNumberContactTextField.backgroundColor = Constants.Colors.defaultColor}
    }
    //---------------FIRST RESPONDER---------------
    
    
    
    //In this functions the values on the textFields are being checked ifEmpty to validate if we can proceed with the action
    @IBAction func AddAction(_ sender: Any) {
        var check = false
        if self.NameContactTextField.text!.isEmpty {self.NameContactTextField.backgroundColor = Constants.Colors.errorColor} else {check = true}
        if self.LastNameContactTextField.text!.isEmpty {self.LastNameContactTextField.backgroundColor = Constants.Colors.errorColor; check = false}
        if self.EmailContactTextField.text!.isEmpty {self.EmailContactTextField.backgroundColor = Constants.Colors.errorColor} else {check = true}
        if self.PhoneNumberContactTextField.text!.isEmpty {self.PhoneNumberContactTextField.backgroundColor = Constants.Colors.errorColor; check = false}
        //if check {self.loginPresenterProtocol?.doLogin()}
        if check {
            self.addContactPresenterProtocol?.addContact(name: self.NameContactTextField.text!, lastName: self.LastNameContactTextField.text!, email: self.EmailContactTextField.text!, phoneNumber: Int(self.PhoneNumberContactTextField.text!) ?? 0)
            
        }

    }
    
}
