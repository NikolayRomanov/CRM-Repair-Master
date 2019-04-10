//
//  ViewController.swift
//  CRM Repair Master
//
//  Created by Macbook on 17.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class MyClientsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var identifierVCaddClient = false
    var objectClients = [PFObject]()
    var searchClients = [PFObject]()

    @IBOutlet weak var navigationItemMyClients: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addTitleVC()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func reloadData() {
        
        let query = PFQuery.init(className: Client.classNameClient.rawValue)
        query.whereKeyExists(Client.myClient.rawValue)
        query.findObjectsInBackground { (optionalObjects, error) in
            if let realObjects = optionalObjects {
                self.objectClients = realObjects
                self.searchClients = self.objectClients
               // print("print objectClients",objectClients)
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchClients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellClinet", for: indexPath)
        searchClients.reverse()
        let objectToDisplay = searchClients[indexPath.row]
        cell.textLabel?.text = objectToDisplay[Client.nameClient.rawValue] as? String
        cell.detailTextLabel?.text = objectToDisplay[Client.phoneNumberClient.rawValue] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let client = searchClients[indexPath.item]
        performSegue(withIdentifier: "showDetailOfClient", sender: client)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailOfClient" {
            if let detailsVC = segue.destination as? DetailsOfClientVC {
                if let senderClient = sender as? PFObject {
                    detailsVC.clientDetail = senderClient
                    detailsVC.visibleButtonAddClientToOrder = identifierVCaddClient
                }
            }
        }
    }
    
    func addTitleVC() {
        if identifierVCaddClient {
            navigationItemMyClients.title = "Add Client to order"
                let cancelButton = UIBarButtonItem(title: "Cancel",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(cancelDismiss))
                navigationItemMyClients.leftBarButtonItem = cancelButton
        }
        else {
            return
        }
    }
    
    @objc func cancelDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchClients = objectClients
            tableView.reloadData()
            return
        }
        searchClients = objectClients.filter({ client -> Bool in
            if let name = client[Client.nameClient.rawValue] as? String {
                return name.contains(searchText)
            }
            else {
                return false
            }
        })
        tableView.reloadData()
    }
    
    
}

