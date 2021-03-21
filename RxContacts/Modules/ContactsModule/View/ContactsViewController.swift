//
//  ContactsViewController.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit
import JJFloatingActionButton

class ContactsViewController: UITableViewController, UISearchBarDelegate {

    var contactsPresenterProtocol : ContactsPresenterProtocol?
    
    var currentIndex : Int?
    
    var currentContacts : Contacts?
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var SegmentController: UISegmentedControl!
    
    @IBOutlet weak var ContactsTableView: UITableView!

    let floatingButton = JJFloatingActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactsPresenterProtocol = ContactsPresenter(contactsView: self)
        
        ContactsTableView.delegate = self
        ContactsTableView.dataSource = self
        
        self.SearchBar.delegate = self
        
        self.currentContacts = Constants.currentUser.contactsInfo
        
        //-------------FLOATING BUTTON------------
        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    
        floatingButton.itemAnimationConfiguration = .circularPopUp(withRadius: 60)
        
        
        floatingButton.addItem(title: "Add Contact", image: UIImage(named: "new_contact")?.withRenderingMode(.alwaysOriginal)) { item in
 
            print("ENTRO AQUI")
            self.contactsPresenterProtocol?.goTo(identifier: Constants.Segues.ContactToNew, from: self)
            
        }
        
        
        floatingButton.configureDefaultItem { item in
            item.titleLabel.textColor = .black
            item.buttonColor = .black
            
            item.layer.shadowOffset = CGSize(width: 0, height: 1)
            item.layer.shadowOpacity = Float(0.4)
        }
        //-------------FLOATING BUTTON------------
        
        
        //-----------DISMISS KEYBOARD------------
        //We create a UITapGestureRecognizer calling the action  UIView.endEditing to dismiss the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //-----------DISMISS KEYBOARD------------
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.currentContacts = Constants.currentUser.contactsInfo
        self.ContactsTableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentContacts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell

        cell.contactName.text = self.currentContacts![indexPath.row].name
        cell.contactLastName.text = self.currentContacts![indexPath.row].lastName
        cell.contactEmail.text = self.currentContacts![indexPath.row].email
        cell.contactPhone.text = String(self.currentContacts![indexPath.row].phoneNumber)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.contactsPresenterProtocol?.goTo(identifier: Constants.Segues.ContactToEdit, from: self)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(self.SearchBar.text?.isEmpty ?? true) {
            if self.SegmentController.selectedSegmentIndex == 1 {
                print("EMAIL")
                self.currentContacts = self.contactsPresenterProtocol?.searchByEmail(search: self.SearchBar.text!)
                self.tableView.reloadData()
            }else if self.SegmentController.selectedSegmentIndex == 2 {
                print("PHONE")
                self.currentContacts = self.contactsPresenterProtocol?.searchByPhone(search: self.SearchBar.text!)
                self.tableView.reloadData()
            }else {
                print("NAME")
                self.currentContacts = self.contactsPresenterProtocol?.searchByName(search: self.SearchBar.text!)
                self.tableView.reloadData()
            }
            self.view.endEditing(true)
        } else {
            self.currentContacts = Constants.currentUser.contactsInfo
            self.view.endEditing(true)
            self.tableView.reloadData()
        }
        
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is EditContactViewController {
            let vc = segue.destination as? EditContactViewController
            vc?.index = self.currentIndex
        }
        
    }
    
}

