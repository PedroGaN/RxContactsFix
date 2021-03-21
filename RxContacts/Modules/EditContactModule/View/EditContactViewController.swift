//
//  EditContactViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/20/21.
//

import Foundation
import UIKit

class EditContactViewController: UIViewController {
    
    var editContactPresenterProtocol : EditContactPresenterProtocol?
    
    var index : Int?
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var ContactImageView: UIImageView!
    
    @IBOutlet weak var ContactNameTextField: UITextField!
    @IBOutlet weak var ContactLastNameTextField: UITextField!
    @IBOutlet weak var ContactEmailTextField: UITextField!
    @IBOutlet weak var ContactPhoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editContactPresenterProtocol = EditContactPresenter(editContactView: self)
        
        //-----------DISMISS KEYBOARD------------
        //We create a UITapGestureRecognizer calling the action  UIView.endEditing to dismiss the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(Constants.currentUser.contactsInfo[index ?? 0])
    }
    
    
    @IBAction func EditContactBTNAction(_ sender: Any) {
        self.tryEditContact(name: self.ContactNameTextField.text!, lastName: self.ContactLastNameTextField.text!, phone: self.ContactPhoneNumberTextField.text!, email: self.ContactEmailTextField.text!)
    }
    
    func tryEditContact(name: String, lastName: String, phone: String, email: String){
        
        self.startPetition()
        self.editContactPresenterProtocol?.editContact(name: name, lastName: lastName, email: email, phoneNumber: phone, index: self.index!, completion: { status in
            if status == "OK" {

                self.endPetition()
                UserHelper.shared.saveUser()
                AlertHelper.shared.getAlert(alertText: "Contact Edited", completion: { alert in
                    self.present(alert, animated: true, completion: nil)
                })
            }else{

                self.endPetition()
                AlertHelper.shared.getAlert(alertText: "Something went wrong", completion: { alert in
                    self.present(alert, animated: true, completion: nil)
                })
            }
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
