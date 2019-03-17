//
//  DetailsOfOrderVC.swift
//  CRM Repair Master
//
//  Created by Macbook on 27.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class DetailsOfOrderVC: UIViewController {
    
    var order : PFObject!
    var objectServices = [PFObject]()
    var statusOrder : Bool!
    var changeObjectServices = true
    var serviceAdd : PFObject!
    
    @IBOutlet weak var labelDateCreateOrder: UILabel!
    @IBOutlet weak var switchStatusOrder: UISwitch!
    @IBOutlet weak var labelStatusOrder: UILabel!
    @IBOutlet weak var labelNameClient: UILabel!
    @IBOutlet weak var labelPhoneNumber: UILabel!
    @IBOutlet weak var labelAddressClient: UILabel!
    @IBOutlet weak var tableViewServices: UITableView!
    @IBOutlet weak var textViewComments: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableViewServices.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        objectToDisplay()
        addService()
        tableViewServices.reloadData()
    }
    
    func dateToDisplay() -> String {
        let date = order.createdAt
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date ?? Date())
        return result
    }
    
    func statusOrderToDisplay() -> String {
        let status = order[Order.statusOrder.rawValue] as? Bool
        if status == true {
            let str = "done"
            switchStatusOrder.setOn(true, animated: false)
            return str
        }
        else {
            let str = "need to perform"
            switchStatusOrder.setOn(false, animated: false)
            return str
        }
    }
    
    func parsingObjectSrevisec() {
        if changeObjectServices {
            let arrayObj = order[Order.servicesInOrder.rawValue] as? [PFObject] ?? [PFObject]()
            for i in arrayObj {
                let query = PFQuery(className: Services.classNameServices.rawValue)
                query.getObjectInBackground(withId: i.objectId!) { (optionalServise, error) in
                    if let realService = optionalServise {
                        self.objectServices.append(realService)
                        self.tableViewServices.reloadData()
                    }
                }
            }
            changeObjectServices = false
        }
        else {
            return
        }
    }
    
    func objectToDisplay() {
        labelDateCreateOrder.text = dateToDisplay()
        labelStatusOrder.text = statusOrderToDisplay()
        let client = order[Order.clientInOrder.rawValue] as? PFObject
        labelNameClient.text = client?[Client.nameClient.rawValue] as? String
        labelPhoneNumber.text = client?[Client.phoneNumberClient.rawValue] as? String
        labelAddressClient.text = client?[Client.address.rawValue] as? String
        textViewComments.text = order[Order.comments.rawValue] as? String
        parsingObjectSrevisec()
    }
    
    func  changeStatusOrder() {
        if switchStatusOrder.isOn {
            labelStatusOrder.text = "done"
            statusOrder = true
        }
        else {
            labelStatusOrder.text = "need to perform"
            statusOrder = false
        }
    }
    
    func addService() {
        if let service = globalService {
            serviceAdd = service
            objectServices.append(serviceAdd)
            globalService = nil
        }
        else {return}
    }
    
    func saveOrder() {
        order[Order.statusOrder.rawValue] = statusOrder ?? order[Order.statusOrder.rawValue]
        order[Order.comments.rawValue] = textViewComments.text
        order[Order.servicesInOrder.rawValue] = objectServices
        order.saveInBackground()
    }
    
    @IBAction func switchStatusOrder(_ sender: Any) {
        changeStatusOrder()
    }
    
    @IBAction func buttonAddService(_ sender: Any) {
        let addServicesVC = true
        performSegue(withIdentifier: "presentAddServices", sender: addServicesVC)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentAddServices" {
            if let myServicesVC = (segue.destination as? UINavigationController)?.topViewController as? MyServicesVC {
                if let senderAddServiceVC = sender as? Bool {
                    myServicesVC.addServices = senderAddServiceVC
                }
            }
        }
    }
    
    @IBAction func barButtonSave(_ sender: Any) {
        saveOrder()
    }
    
}

extension DetailsOfOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath)
        let objectToCell = objectServices[indexPath.row]
        cell.textLabel?.text = objectToCell[Services.name.rawValue] as? String
        cell.detailTextLabel?.text = objectToCell[Services.price.rawValue] as? String
        
        return cell
    }
}
