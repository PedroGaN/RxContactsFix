//
//  NetworkManager.swift
//  RxContacts
//
//  Created by user177273 on 3/6/21.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class NetworkManager: NetworkManagerProtocol {
    
    let defaults = UserDefaults.standard
    var currentUser : Any?
    
    func checkUser(){
        guard let savedUser = defaults.object(forKey: "SavedUser") as? User else {return}
        self.currentUser = savedUser
    }
    
    static var shared: NetworkManager = NetworkManager()
    
    func request(path: String, method: HTTPMethod, parameters: [String: Any]? = [:], headers: HTTPHeaders? = [],petition: String, completion: @escaping (String) -> Void) {
        
        let url : String = Constants.baseUrl + path
        
        switch petition {
        case "login","register","update":
            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers)
                .validate()
                .responseDecodable(of: LogRegUpResponse.self) { (response) in
                    guard let completionValue = response.value else { return }
                    if completionValue[0].status == "OK" { self.currentUser = completionValue[0].user }
                    completion(completionValue[0].status)
                }
        case "delete","logout":
            AF.request(url, method: method, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
                .validate()
                .responseDecodable(of: String.self) { (response) in
                    guard let completionValue = response.value else { return }
                    completion(completionValue)
                }
        case "contacts":
            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers)
                .validate()
                .responseDecodable(of: User.self) { (response) in
                    guard let completionValue = response.value else { return }
                    //if completionValue.id != 0 {completion(completionValue)}
                    completion("ERROR")
                }
        case "users":
            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers)
                .validate()
                .responseDecodable(of: Users.self) { (response) in
                    guard let completionValue = response.value else { return }
                    //if completionValue.count != 0 { completion(completionValue) }
                    completion("ERROR")
                }
        default:
            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers)
                .validate()
                .responseDecodable(of: String.self) { (response) in
                    //guard let completionValue = response.value else { return }
                    //completion(completionValue)
                }
        }
    }
    
    func login(parameters: [String:Any], completion: @escaping (String) -> Void) {
        
        request(path: "login", method: .post, parameters: parameters, petition: "login", completion: { LoginResponse in
            print(self.currentUser!)
            completion(LoginResponse)
        })
    }
    
    func register(parameters: [String:Any]) -> Bool {
        
        var check : Bool = false
        
        request(path: "register", method: .post, parameters: parameters, petition: "register", completion: { RegisterResponse in
            guard let user = RegisterResponse as? User else {return}
            self.currentUser = user
            check = true
        })
        
        return check
    }
    
    func update(parameters: [String:Any], headers: HTTPHeaders) -> Bool{
        
        var check : Bool = false
        
        request(path: "update", method: .post, parameters: parameters, headers: headers, petition: "update", completion: { UpdateResponse in
            guard let user = UpdateResponse as? User else {return}
            self.currentUser = user
            check = true
        })
        
        return check
    }
    
    func logout(parameters: [String:Any], headers: HTTPHeaders) -> Bool{
        
        var check : Bool = true
        
        request(path: "logout", method: .post, parameters: parameters, headers: headers,petition: "logout", completion: { LogoutResponse in
            if "OK" == LogoutResponse as? String {self.defaults.removeObject(forKey: "SavedUsed")} else {check = false}
        })
        
        return check
    }
    
    func delete(parameters: [String:Any], headers: HTTPHeaders) -> Bool{
        
        var check : Bool = true
        
        request(path: "delete", method: .post, parameters: parameters, headers: headers,petition: "delete", completion: { DeleteResponse in
            if "OK" == DeleteResponse as? String {self.defaults.removeObject(forKey: "SavedUsed")} else {check = false}
        })
        
        return check
    }
    
    func contacts(parameters: [String:Any], headers: HTTPHeaders) -> Bool{
        
        var check : Bool = false
        
        request(path: "contacts", method: .post, parameters: parameters, headers: headers,petition: "contacts", completion: { ContactsResponse in
            guard let user = ContactsResponse as? User else {return}
            self.currentUser = user
            check = true
        })
        
        return check
    }
    
    func rememberPassword() {
        //TO DO
    }
    
    func fetchUsers() -> Users {
        
        var user : Users?
        
        request(path: "fetch", method: .get, petition: "users", completion: { UsersResponse in
            user = UsersResponse as? Users
        })
        
        return user!
    }
}

protocol NetworkManagerProtocol {
    func request(path: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders?,petition: String, completion: @escaping (String) -> Void)
    func login(parameters: [String:Any], completion: @escaping (String) -> Void)
    func register(parameters: [String:Any]) -> Bool
    func update(parameters: [String:Any], headers: HTTPHeaders) -> Bool
    func logout(parameters: [String:Any], headers: HTTPHeaders) -> Bool
    func delete(parameters: [String:Any], headers: HTTPHeaders) -> Bool
    func contacts(parameters: [String:Any], headers: HTTPHeaders) -> Bool
    func fetchUsers() -> Users
    
    //TO DO
    func rememberPassword()
    
    func checkUser()
}
