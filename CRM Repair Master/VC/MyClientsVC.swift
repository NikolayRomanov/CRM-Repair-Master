//
//  ViewController.swift
//  CRM Repair Master
//
//  Created by Macbook on 17.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class MyClientsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
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
        let query = PFQuery.init(className: classNameClient)
        query.findObjectsInBackground { (optionalObjects, error) in
            if let realObjects = optionalObjects {
                objectClients = realObjects
                print("print objectClients",objectClients)
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectClients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellClinet", for: indexPath)
        let objectToDisplay = objectClients[indexPath.row]
        cell.textLabel?.text = objectToDisplay[nameClient] as? String
        cell.detailTextLabel?.text = objectToDisplay[phoneNumberClient] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let client = objectClients[indexPath.item]
        performSegue(withIdentifier: "showDetailOfClient", sender: client)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailOfClient" {
            if let detailsVC = segue.destination as? DetailsOfClientVC {
                if let senderClient = sender as? PFObject {
                    detailsVC.clientDetail = senderClient
                }
            }
        }
    }
    
}

