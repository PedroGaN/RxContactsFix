//
//  UserDetailPresenter.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class UserDetailPresenter: UserDetailPresenterProtocol {
    
    var userDetailView : UserDetailViewController?
    var currentUser : User?
    
    init (userDetailView: UserDetailViewController){
        self.userDetailView = userDetailView
    }
    
    func getUser() {
        /*let savedUser : Data = NetworkManager.shared.defaults.object(forKey: "saved_user") as! Data
        if let decodedUser = try? JSONDecoder().decode(User.self, from: savedUser){
            self.currentUser = decodedUser
        }*/
    }
    
    func setDetails() {
        self.getUser()
        self.userDetailView?.userNameLabel.text = self.currentUser!.name + " " + self.currentUser!.lastName
        self.userDetailView?.userEmailLabel.text = self.currentUser!.email
        let dataDecoded : Data  = Data(base64Encoded: self.currentUser!.userImage, options: .ignoreUnknownCharacters)!
        let decodedImage = UIImage(data: dataDecoded)
        self.userDetailView?.userImageUIImageView.image = decodedImage
    }
    
    func updatePassword(newPass: String, password: String) {
        if password == self.currentUser?.apiToken {
            self.currentUser?.apiToken = password
            let encodedUser = try? JSONEncoder().encode(self.currentUser)
            
            NetworkManager.shared.defaults.setValue(encodedUser, forKey: "saved_user")
        }else{
            self.userDetailView?.userPasswordTextField.text = "Wrong Password"
        }
        
    }
    
    func deleteUser(password: String) {
        if password == self.currentUser?.apiToken {
            NetworkManager.shared.defaults.removeObject(forKey: "saved_user")
            exit(0)
        }else{
            self.userDetailView?.userPasswordTextField.text = "Wrong Password"
        }
    }
    
}

protocol UserDetailPresenterProtocol{
    func getUser()
    func setDetails()
    func updatePassword(newPass: String, password: String)
    func deleteUser(password: String)
}
