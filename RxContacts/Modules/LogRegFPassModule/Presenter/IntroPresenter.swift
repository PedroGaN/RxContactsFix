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
    
    var VController : Any?
    
    var view : UIView?
    
    init (loginView: LoginViewController? = nil, registerView: RegisterViewController? = nil){
        
        if let VC : LoginViewController = loginView { self.view = VC.view; self.VController = VC }
        if let VC = registerView { self.view = VC.view; self.VController = VC }
        
    }
    
    func doRegister() {
        print("entro")
        //NetworkManager.shared.register(parameters: <#T##[String : Any]#>)
    }
    
    func doRememberPassword() {
        //NetworkManager.shared.rememberPassword()
    }
    
    func doLogin(email: String, password: String, completion: @escaping (String) -> Void) {
        
        let parameters = [
            
            "email" : email,
            "password" : password
        ]
        
        NetworkManager.shared.login(parameters: parameters, completion: { status in
            completion(status)
        })
    }
    
    func goTo(identifier: String, from: UIViewController) {
        from.performSegue(withIdentifier: identifier, sender: Any?.self)
    }
    
    //Here we create a false user based on our struct
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
    
    //Checks if there is a saved user and if it is it jumps into the main app
    func checkUser() -> Bool{
        if NetworkManager.shared.defaults.object(forKey: "saved_user") != nil {
            return true
        } else {
            return false
        }
    }

}

protocol IntroPresenterProtocol{
    func doLogin(email: String, password: String, completion: @escaping (String) -> Void)
    func doRememberPassword()
    func goTo(identifier: String, from: UIViewController)
    func saveUser(email: String, password: String)
    func checkUser() -> Bool
}
