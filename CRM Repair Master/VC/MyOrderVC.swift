//
//  MyOrderVC.swift
//  CRM Repair Master
//
//  Created by Macbook on 27.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class MyOrderVC: UIViewController {

    var objectOrders = [PFObject]()
    
    @IBOutlet weak var tableViewOrders: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOrders.dataSource = self
        tableViewOrders.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func reloadData() {
        let query = PFQuery.init(className: Order.classNameOrder.rawValue)
        query.whereKeyExists(Order.myOrder.rawValue)
        query.findObjectsInBackground { (optionalObjects, error) in
            if let realObjects = optionalObjects {
                self.objectOrders = realObjects
                //print("print objectClients",objectOrders)
                self.tableViewOrders.reloadData()
            }
        }
    }
    
}

extension MyOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOrders.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath)
        let object = objectOrders[indexPath.row]
        let post = object[Order.clientInOrder.rawValue] as! PFObject
        post.fetchIfNeededInBackground { (post: PFObject?, error: Error?) in
            let nameClientObject = post?[Client.nameClient.rawValue] as? String
            cell.textLabel?.text = nameClientObject
        }        
        return cell
    }
}

extension MyOrderVC: UITableViewDelegate {
    
}

