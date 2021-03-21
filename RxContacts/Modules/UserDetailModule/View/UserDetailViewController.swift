//
//  UserDetailViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController {
    
    var userDetailPresenterProtocol : UserDetailPresenterProtocol?
    
    @IBOutlet weak var UserImageView: UIImageView!
    
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var UserLastNameLabel: UILabel!
    @IBOutlet weak var UserEmailLabel: UILabel!
    @IBOutlet weak var UserPhoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userDetailPresenterProtocol = UserDetailPresenter(userDetailView: self)
        
        self.userDetailPresenterProtocol?.setDetails()
        
        //-----------DISMISS KEYBOARD------------
        //We create a UITapGestureRecognizer calling the action  UIView.endEditing to dismiss the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
        
    }
    
    @IBAction func DeleteUserBTNAction(_ sender: Any) {
    }
    
    @IBAction func LogoutUserBTNAction(_ sender: Any) {
    }
    
}
