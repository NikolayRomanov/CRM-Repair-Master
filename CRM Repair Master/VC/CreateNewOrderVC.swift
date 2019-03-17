//
//  CreateNewOrderVC.swift
//  CRM Repair Master
//
//  Created by Macbook on 27.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class CreateNewOrderVC: UIViewController {
    
    var clientAdd : PFObject!
    var serviceAdd : PFObject!
    var arrayServisec = [PFObject]()
    var statusOrder = false
    
    @IBOutlet weak var labelPhoneNumber: UILabel!
    @IBOutlet weak var labelNameClient: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var tabelViewServicesInOrder: UITableView!
    @IBOutlet weak var textViewComments: UITextView!
    @IBOutlet weak var switchStatus: UISwitch!
    @IBOutlet weak var labelStatusOrder: UILabel!
    @IBOutlet weak var labelDateNow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("serviceAdd", serviceAdd)
        changeStatusOrder()
        dateNow()
        
        tabelViewServicesInOrder.dataSource = self
        tabelViewServicesInOrder.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addClient()
        addService()
        tabelViewServicesInOrder.reloadData()
        print("arrayServisec", arrayServisec)
    }
    
    func dateNow() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        labelDateNow.text = result
    }
    
    func  changeStatusOrder() {
        if switchStatus.isOn {
            labelStatusOrder.text = "done"
            statusOrder = true
        }
        else {
            labelStatusOrder.text = "need to perform"
            statusOrder = false
        }
    }
    
    func addClient() {
        if let client = globalClient {
            clientAdd = client
            globalClient = nil
            labelNameClient.text = clientAdd[Client.nameClient.rawValue] as? String
            labelPhoneNumber.text = clientAdd[Client.phoneNumberClient.rawValue] as? String
            labelAddress.text = clientAdd[Client.address.rawValue] as? String
            
        }
        else {return}
    }
    
    func addService() {
        if let service = globalService {
            serviceAdd = service
            arrayServisec.append(serviceAdd)
            globalService = nil
        }
        else {return}
    }
    
    func creatNewOrder() {
        let newOrder = PFObject.init(className: Order.classNameOrder.rawValue)
        newOrder[Order.clientInOrder.rawValue] = clientAdd
        newOrder[Order.nameClientOrder.rawValue] = clientAdd[Client.nameClient.rawValue]
        newOrder[Order.servicesInOrder.rawValue] = arrayServisec
        newOrder[Order.statusOrder.rawValue] = statusOrder
        newOrder[Order.comments.rawValue] = textViewComments.text
        newOrder[Order.myOrder.rawValue] = PFUser.current()
        newOrder.saveInBackground { (success, error) in
            
            guard let user = PFUser.current(), success else {
                return
            }
            user.relation(forKey: Order.relationForKeyOrders.rawValue).add(newOrder)
            user.saveInBackground()
        }
    }
    
    @IBAction func statusOrder(_ sender: Any) {
        changeStatusOrder()
    }
    
    @IBAction func rightBarButtonDone(_ sender: Any) {
        creatNewOrder()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftBarButtonCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonAddClient(_ sender: Any) {
        let addClientVC = true
        performSegue(withIdentifier: "addClientToOrder", sender: addClientVC)
    }
    
    @IBAction func buttonAddServices(_ sender: Any) {
        let addServicesVC = true
        performSegue(withIdentifier: "presentAddServices", sender: addServicesVC)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addClientToOrder" {
            if let myClientsVC = (segue.destination as? UINavigationController)?.topViewController as? MyClientsVC {
                if let senderAddClientVC = sender as? Bool {
                    myClientsVC.identifierVCaddClient = senderAddClientVC
                }
            }
        }
        
        if segue.identifier == "presentAddServices" {
            if let myServicesVC = (segue.destination as? UINavigationController)?.topViewController as? MyServicesVC {
                if let senderAddServiceVC = sender as? Bool {
                    myServicesVC.addServices = senderAddServiceVC
                }
            }
        }
    }
    
}

extension CreateNewOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayServisec.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath)
        let objectToDisplay = arrayServisec[indexPath.row]
        cell.textLabel?.text = objectToDisplay[Services.name.rawValue] as? String
        cell.detailTextLabel?.text = objectToDisplay[Services.price.rawValue] as? String
        
        return cell
    }
    
    
}

extension CreateNewOrderVC: UITableViewDelegate {
    
}



