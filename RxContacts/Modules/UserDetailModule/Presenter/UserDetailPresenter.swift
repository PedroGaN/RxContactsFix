//
//  UserDetailPresenter.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit
import Alamofire

class UserDetailPresenter: UserDetailPresenterProtocol {
    
    var userDetailView : UserDetailViewController?
    
    init (userDetailView: UserDetailViewController){
        self.userDetailView = userDetailView
    }
       
    func setDetails() {

        if Constants.currentUser.id != 0{
            self.userDetailView?.UserNameLabel.text = Constants.currentUser.name
            self.userDetailView?.UserLastNameLabel.text = Constants.currentUser.lastName
            self.userDetailView?.UserEmailLabel.text = Constants.currentUser.email
            self.userDetailView?.UserPhoneLabel.text = String(Constants.currentUser.phoneNumber)
            if Constants.currentUser.userImage != "" {
                let dataDecoded : Data  = Data(base64Encoded: Constants.currentUser.userImage, options: .ignoreUnknownCharacters)!
                let decodedImage = UIImage(data: dataDecoded)
                self.userDetailView?.UserImageView.image = decodedImage
            }
        }
    }
    
    func logoutUser(completion: @escaping (String) -> Void) {
        
        let headers : HTTPHeaders = [ "Authorization" : "Bearer " + Constants.currentUser.apiToken]
        let parameters = [ "id" : Constants.currentUser.id ]
        
        NetworkManager.shared.logout(parameters: parameters, headers: headers, completion: { status in
            completion(status)
        })
        
    }
    
    func goTo(identifier: String, from: UIViewController) {
        from.performSegue(withIdentifier: identifier, sender: Any?.self)
    }
    
}

protocol UserDetailPresenterProtocol{
    func setDetails()
    func logoutUser(completion: @escaping (String) -> Void)
    func goTo(identifier: String, from: UIViewController)
}
