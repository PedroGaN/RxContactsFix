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
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var ContactImageView: UIImageView!
    @IBOutlet weak var ContactNameTextField: UITextField!
    @IBOutlet weak var ContactLastNameTextField: UITextField!
    @IBOutlet weak var ContactEmailTextField: UITextField!
    @IBOutlet weak var ContactPhoneNumberTextField: UITextField!
    
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
    
    
    @IBAction func AddContactButtonAction(_ sender: Any) {
        self.tryAddContact(name: self.ContactNameTextField.text!, lastName: self.ContactLastNameTextField.text!, phone: self.ContactPhoneNumberTextField.text!, email: self.ContactEmailTextField.text!)
    }
    
    func tryAddContact(name: String, lastName: String, phone: String, email: String){
        var check = false
        var alertString = "Missing "
        if name.isEmpty {alertString += "| Name "} else {check = true}
        if lastName.isEmpty {alertString += "| LastName "; check = false}
        if phone.isEmpty {alertString += "| PhoneNumber "; check = false}
        if email.isEmpty {alertString += "| Email "; check = false}
        if check {
            self.startPetition()
            self.addContactPresenterProtocol?.addContact(name: name, lastName: lastName, email: email, phoneNumber: Int(phone) ?? 0, completion: { status in
                if status == "OK" {

                    self.endPetition()
                    UserHelper.shared.saveUser()
                    AlertHelper.shared.getAlert(alertText: "New Contact Added", completion: { alert in
                        self.present(alert, animated: true, completion: nil)
                    })
                }else{

                    self.endPetition()
                    AlertHelper.shared.getAlert(alertText: "Something went wrong", completion: { alert in
                        self.present(alert, animated: true, completion: nil)
                    })
                }
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
    
}
