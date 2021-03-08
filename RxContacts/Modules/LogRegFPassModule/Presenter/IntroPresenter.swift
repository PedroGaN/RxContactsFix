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
        //NetworkManager.shared.register(parameters: <#T##[String : Any]#>)
    }
    
    func doRememberPassword() {
        //NetworkManager.shared.rememberPassword()
    }
    
    func doLogin() {
        //NetworkManager.shared.login(parameters: <#T##[String : Any]#>)
    }
    
    func goTo(identifier: String, from: UIViewController) {
        from.performSegue(withIdentifier: identifier, sender: Any?.self)
    }
    
    func saveUser(email:String, password: String){
        let image : UIImage = UIImage(named: "default_user")!
        let imageData : Data = image.pngData()!
        let base64Image = imageData.base64EncodedString(options: .lineLength64Characters)
        let contact1 = ContactsInfo(name: "Iván", lastName: "de Prada", email: "ivan@deprada", phoneNumber: 123654789)
        let contact2 = ContactsInfo(name: "Juan", lastName: "J. Carro", email: "juan@jcarro", phoneNumber: 987456321)
        let contacts : Contacts = [contact1,contact2]
        
        let user = User(id: 1, name: "Rupert", lastName: "Segundo", email: email, phoneNumber: 123654789, userImage: base64Image, contactsInfo: contacts, apiToken: "soy_un_api_token", createdAt: "fecha1", updatedAt: "fecha2")
        let encodedUser = try? JSONEncoder().encode(user)
        
        NetworkManager.shared.defaults.setValue(encodedUser, forKey: "saved_user")
        let savedUser : Data = NetworkManager.shared.defaults.object(forKey: "saved_user") as! Data
        if let decodedUser = try? JSONDecoder().decode(User.self, from: savedUser){
            print(decodedUser)
        }
    }

}

protocol IntroPresenterProtocol{
    func doLogin()
    func doRegister()
    func doRememberPassword()
    func goTo(identifier: String, from: UIViewController)
    func saveUser(email: String, password: String)
}
