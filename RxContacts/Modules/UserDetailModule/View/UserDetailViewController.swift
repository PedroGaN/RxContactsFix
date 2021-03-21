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
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userDetailPresenterProtocol = UserDetailPresenter(userDetailView: self)
        
        //-----------DISMISS KEYBOARD------------
        //We create a UITapGestureRecognizer calling the action  UIView.endEditing to dismiss the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.userDetailPresenterProtocol?.setDetails()
    }
    
    @IBAction func DeleteUserBTNAction(_ sender: Any) {

        AlertHelper.shared.getDeleteUserAlert(view: self,completion: {alert in
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    
    @IBAction func LogoutUserBTNAction(_ sender: Any) {
        self.startPetition()
        self.userDetailPresenterProtocol?.logoutUser(completion: { status in
            self.endPetition()
            if status == "OK" {exit(0)}
            else { AlertHelper.shared.getAlert(alertText: "Something Went Wrong", completion: { alert in
                self.present(alert, animated: true, completion: nil)
            })}
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
