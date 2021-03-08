//
//  ContactsViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var contactsPresenterProtocol : ContactsPresenterProtocol?
    
    @IBOutlet weak var ContactsTableView: UITableView!
    
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactsPresenterProtocol = ContactsPresenter(contactsView: self)
        
        self.contactsPresenterProtocol?.getUser()
        //print(currentUser)
        
        ContactsTableView.delegate = self
        ContactsTableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.contactsPresenterProtocol?.getUser()
        self.ContactsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUser?.contactsInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        //print(currentUser?.contactsInfo[indexPath.row])
        cell.contactName.text = self.currentUser?.contactsInfo[indexPath.row].name
        cell.contactLastName.text = self.currentUser?.contactsInfo[indexPath.row].lastName
        cell.contactEmail.text = self.currentUser?.contactsInfo[indexPath.row].email
        cell.contactPhone.text = String((self.currentUser?.contactsInfo[indexPath.row].phoneNumber)!)
        cell.deleteButtonTapCallback = {
            self.currentUser?.contactsInfo.remove(at: indexPath.row)
            let encodedUser = try? JSONEncoder().encode(self.currentUser)
            
            NetworkManager.shared.defaults.setValue(encodedUser, forKey: "saved_user")
            tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

