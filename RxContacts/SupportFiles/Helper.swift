//
//  Helper.swift
//  RxContacts
//
//  Created by user177273 on 3/19/21.
//

import Foundation
import UIKit

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
    
}

protocol AlertHelperProtocol {
    func getAlert(alertText: String, completion: @escaping (UIAlertController) -> Void)
    func getRecoverPasswordAlert(completion: @escaping (UIAlertController) -> Void)
}
