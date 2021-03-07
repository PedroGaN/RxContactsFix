//
//  IntroPresenter.swift
//  RxContacts
//
//  Created by user177273 on 3/7/21.
//

import Foundation
import UIKit
import Alamofire

class IntroPresenter: IntroPresenterProtocol {
    
    var loginView : LoginViewController?
    var registerView : RegisterViewController?
    var forgotPasswordView : ForgotPasswordViewController?
    
    init (loginView: LoginViewController? = nil, registerView: RegisterViewController? = nil, forgotPasswordView: ForgotPasswordViewController? = nil){
        
        if(loginView != nil){self.loginView = loginView}
        if(registerView != nil){self.registerView = registerView}
        if(forgotPasswordView != nil){self.forgotPasswordView = forgotPasswordView}
        
    }
    
    func doRegister() {
        
    }
    
    func doRememberPassword() {
        
    }
    
    func doLogin() {

    }
    
}

protocol IntroPresenterProtocol{
    func doLogin()
    func doRegister()
    func doRememberPassword()
}
