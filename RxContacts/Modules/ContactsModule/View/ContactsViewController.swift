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
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.ContactsTableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.currentUser.contactsInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell

        cell.contactName.text = Constants.currentUser.contactsInfo[indexPath.row].name
        cell.contactLastName.text = Constants.currentUser.contactsInfo[indexPath.row].lastName
        cell.contactEmail.text = Constants.currentUser.contactsInfo[indexPath.row].email
        cell.contactPhone.text = String((Constants.currentUser.contactsInfo[indexPath.row].phoneNumber))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.contactsPresenterProtocol?.goTo(identifier: Constants.Segues.ContactToEdit, from: self)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.SegmentController.selectedSegmentIndex == 1 {
            print("EMAIL")
            //TO DO SEARCH BY EMAIL
        }else if self.SegmentController.selectedSegmentIndex == 2 {
            print("PHONE")
            //TO DO SEARCH BY PHONE
        }else {
            print("NAME")
            //TO DO SEARCH BY NAME
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is EditContactViewController {
            let vc = segue.destination as? EditContactViewController
            vc?.index = self.currentIndex
        }
        
    }
    
}

