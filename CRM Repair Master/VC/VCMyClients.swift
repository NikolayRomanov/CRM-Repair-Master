//
//  ViewController.swift
//  CRM Repair Master
//
//  Created by Macbook on 17.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit

class VCMyClients: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let client = Client.init()
        client.name = "Niklay"
        client.secondName = "Ronanov"
        client.phonenumber = "0684564804"
        allClients.append(client)
        print(allClients[0].name)
        print(allClients[0].secondName)
        print(allClients[0].phonenumber)
        
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellClinet", for: indexPath)
        let objectToDisplay = allClients[indexPath.row]
        cell.textLabel?.text = objectToDisplay.name + " " + objectToDisplay.secondName
        cell.detailTextLabel?.text = objectToDisplay.phonenumber
        
        return cell
    }
    
}

