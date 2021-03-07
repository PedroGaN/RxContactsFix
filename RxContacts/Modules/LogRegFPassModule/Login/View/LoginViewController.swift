//
//  LoginViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/7/21.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    var loginPresenterProtocol : IntroPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loginPresenterProtocol = IntroPresenter(loginView: self)
        
        self.loginPresenterProtocol?.doLogin()
        
        
    }


}
