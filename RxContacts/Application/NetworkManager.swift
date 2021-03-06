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
    
    static var shared: NetworkManager = NetworkManager()
    
    func request(path: String, method: HTTPMethod, parameters: [String: Any]? = [:], headers: HTTPHeaders? = [],petition: String, completion: @escaping (String) -> Void) {
        
        let url : String = Constants.baseUrl + path
        
        switch petition {
        case "login","register","update":
            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers)
                .validate()
                .responseDecodable(of: LogRegUpResponse.self)
                { (response) in
                    print(response)
                    guard let completionValue = response.value else { completion("KO"); return }
    
                    if completionValue[0].status == "OK" { Constants.currentUser = completionValue[0].user }
                    print(Constants.currentUser)
                    completion(completionValue[0].status)
                }
        case "delete","logout","contacts":
            AF.request(url, method: method, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
                .validate()
                .responseString() { (response) in
                    print(response)
                    guard let completionValue = response.value else { completion("KO"); return }
                    completion(completionValue)
                }

        default:
            completion("KO")
        }
    }
    
    func login(parameters: [String:Any], completion: @escaping (String) -> Void) {
        
        request(path: "login", method: .post, parameters: parameters, petition: "login", completion: { LoginResponse in
            print(Constants.currentUser)
            completion(LoginResponse)
        })
    }
    
    func register(parameters: [String:Any], completion: @escaping (String) -> Void) {
            
        request(path: "register", method: .post, parameters: parameters, petition: "register", completion: { RegisterResponse in
            print(Constants.currentUser)
            completion(RegisterResponse)
        })
    }
    
    func update(parameters: [String:Any], headers: HTTPHeaders, completion: @escaping (String) -> Void){
        
        request(path: "update", method: .post, parameters: parameters, headers: headers, petition: "update", completion: { UpdateResponse in
            print(Constants.currentUser)
            completion(UpdateResponse)
        })
    }
    
    //TO DO
    func logout(parameters: [String:Any], headers: HTTPHeaders, completion: @escaping (String) -> Void) {
        
        request(path: "logout", method: .post, parameters: parameters, headers: headers,petition: "logout", completion: { LogoutResponse in
            if "OK" == LogoutResponse {
                UserHelper.shared.deleteStoredUser()
                completion(LogoutResponse)
            } else {completion(LogoutResponse)}
        })

    }
    
    //TO DO
    func delete(parameters: [String:Any], headers: HTTPHeaders, completion: @escaping (String) -> Void) {
        
        request(path: "delete", method: .post, parameters: parameters, headers: headers,petition: "delete", completion: { DeleteResponse in
            if "OK" == DeleteResponse {
                UserHelper.shared.deleteStoredUser()
                completion(DeleteResponse)
            } else {completion(DeleteResponse)}
        })
    }
    
    //TO DO
    func contacts(parameters: [String:Any], headers: HTTPHeaders, completion: @escaping (String) -> Void) {
        
        request(path: "contacts", method: .post, parameters: parameters, headers: headers,petition: "contacts", completion: { ContactsResponse in
            print(Constants.currentUser)
            completion(ContactsResponse)
        })
    }
    
    func rememberPassword() {
        //TO DO
    }
}

protocol NetworkManagerProtocol {
    func request(path: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders?,petition: String, completion: @escaping (String) -> Void)
    func login(parameters: [String:Any], completion: @escaping (String) -> Void)
    func register(parameters: [String:Any], completion: @escaping (String) -> Void)
    func update(parameters: [String:Any], headers: HTTPHeaders, completion: @escaping (String) -> Void)
    func logout(parameters: [String:Any], headers: HTTPHeaders, completion: @escaping (String) -> Void)
    func delete(parameters: [String:Any], headers: HTTPHeaders, completion: @escaping (String) -> Void)
    func contacts(parameters: [String:Any], headers: HTTPHeaders, completion: @escaping (String) -> Void)
    //func fetchUsers() -> Users
    
    //TO DO
    func rememberPassword()
}
