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
        let query = PFQuery.init(className: classNameOrder)
        query.whereKeyExists(myOrder)
        query.findObjectsInBackground { (optionalObjects, error) in
            if let realObjects = optionalObjects {
                objectOrders = realObjects
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
        let objectToDisplay = objectOrders[indexPath.row]
        cell.textLabel?.text = objectToDisplay[orderClassNameClient] as? String
        
        return cell
    }
}

extension MyOrderVC: UITableViewDelegate {
    
}

