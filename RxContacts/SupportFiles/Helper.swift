//
//  Helper.swift
//  RxContacts
//
//  Created by user177273 on 3/19/21.
//

import Foundation
import UIKit
import Alamofire

class AlertHelper: AlertHelperProtocol {
    
    static var shared: AlertHelper = AlertHelper()
    
    func getAlert(alertText: String, completion: @escaping (UIAlertController) -> Void) {
            
        let actionSheetMenu = UIAlertController(title: nil, message: alertText, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            actionSheetMenu.dismiss(animated: true, completion: nil)
        }
            
        actionSheetMenu.addAction(cancelAction)
        
        completion(actionSheetMenu)
                    
    }
    
    func getRecoverPasswordAlert(completion: @escaping (UIAlertController) -> Void) {
        
        let alertController = UIAlertController(title: "Recover Password", message: "Type your Account Email", preferredStyle: .alert)
        
        let recoverPasswordAction = UIAlertAction(title: "Recover Password", style: .default) { action in
            if let txtField = alertController.textFields?.first, let email = txtField.text {
                
                //TO DO
                print("new password")
                print(email)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
            textField.textAlignment = .center
        }
        
        alertController.addAction(recoverPasswordAction)
        alertController.addAction(cancelAction)
        
        completion(alertController)
        
    }
    
    func getDeleteUserAlert(view: UserDetailViewController, completion: @escaping (UIAlertController) -> Void) {
        
        let alertController = UIAlertController(title: "Delete User", message: "Type your Account Password", preferredStyle: .alert)
        
        let deleteUserAction = UIAlertAction(title: "Delete User", style: .default) { action in
            if let txtField = alertController.textFields?.first, let password = txtField.text {
                
                txtField.isSecureTextEntry = true
                txtField.autocorrectionType = .no
                //TO DO

                let headers : HTTPHeaders = [ "Authorization" : "Bearer " + Constants.currentUser.apiToken]
                let parameters : [String : Any] = [ "id" : Constants.currentUser.id, "password" : password ]
                
                view.startPetition()
                
                NetworkManager.shared.delete(parameters: parameters, headers: headers, completion: { status in
                    view.endPetition()
                    if status == "OK" {
                        UserHelper.shared.deleteStoredUser()
                        exit(0)
                    } else {
                        print("Something went wrong")
                    }
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.textAlignment = .center
        }
        
        alertController.addAction(deleteUserAction)
        alertController.addAction(cancelAction)
        
        completion(alertController)
        
    }
    
    func getUpdateUserAlert(view: EditUserViewController, completion: @escaping (UIAlertController) -> Void) {
        
        let alertController = UIAlertController(title: "Update User", message: "Type your Account Password", preferredStyle: .alert)
        
        let updateUserAction = UIAlertAction(title: "Update User", style: .default) { action in
            if let txtField = alertController.textFields?.first, let password = txtField.text {
                
                txtField.isSecureTextEntry = true
                txtField.autocorrectionType = .no
                //TO DO

                let headers : HTTPHeaders = [ "Authorization" : "Bearer " + Constants.currentUser.apiToken]
                let parameters : [String : Any] =
                    [
                        "id" : Constants.currentUser.id,
                        "password" : password,
                        "name" : view.UserNameTextField.text ?? "",
                        "last_name" : view.UserLastNameTextField.text ?? "",
                        "email" : view.UserEmailTextField.text ?? "",
                        "contacts_info" : ""
                    ]
                
                view.startPetition()
                
                NetworkManager.shared.update(parameters: parameters, headers: headers, completion: { status in
                    view.endPetition()
                    if status == "OK" {
                        UserHelper.shared.saveUser()
                        view.clearFields()
                        print(status)
                    } else {
                        print("Something went wrong")
                    }
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.textAlignment = .center
        }
        
        alertController.addAction(updateUserAction)
        alertController.addAction(cancelAction)
        
        completion(alertController)
        
    }
    
    
}

protocol AlertHelperProtocol {
    func getAlert(alertText: String, completion: @escaping (UIAlertController) -> Void)
    func getRecoverPasswordAlert(completion: @escaping (UIAlertController) -> Void)
}

class UserHelper: UserHelperProtocol {
    
    let defaults = UserDefaults.standard
    
    static var shared: UserHelper = UserHelper()
    
    func saveUser(){
        
        //SAVE IMAGE
        /*let image : UIImage = UIImage(named: "default_user")!
        let imageData : Data = image.pngData()!
        let base64Image = imageData.base64EncodedString(options: .lineLength64Characters)*/
        
        let encodedUser = try? JSONEncoder().encode(Constants.currentUser)
        self.defaults.setValue(encodedUser, forKey: "saved_user")
    }
    
    func checkUser() -> Bool{
        
        if let data = UserHelper.shared.defaults.data(forKey: "saved_user") {
            do {
                let savedUser = try JSONDecoder().decode(User.self, from: data)
                if savedUser.id != 0 { Constants.currentUser = savedUser }
                return true
            } catch {
                print("User unable to decode")
                return false
            }
        }
        
        return false
    }
    
    func deleteStoredUser() {
        self.defaults.removeObject(forKey: "saved_user")
    }
}

protocol UserHelperProtocol{
    func saveUser()
    func checkUser() -> Bool
    func deleteStoredUser()
}
