//
//  RegisterViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/7/21.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    var registerPresenterProtocol : IntroPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.registerPresenterProtocol = IntroPresenter(registerView: self)
        
    }


}
