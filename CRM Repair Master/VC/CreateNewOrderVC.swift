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
    
    @IBOutlet weak var labelNameClient: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("serviceAdd", serviceAdd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addClient()
        addService()
        print("serviceAdd", serviceAdd)
    }
    
    func addClient() {
        if let client = globalClient {
            clientAdd = client
            globalClient = nil
            labelNameClient.text = clientAdd[Client.nameClient.rawValue] as? String
        }
        else {return}
    }
    
    func addService() {
        if let service = globalService {
            serviceAdd = service
            globalService = nil
        }
        else {return}
    }
    
    func creatNewOrder() {
        let newOrder = PFObject.init(className: Order.classNameOrder.rawValue)
        newOrder[Order.clientInOrder.rawValue] = clientAdd
        newOrder[Order.nameClientOrder.rawValue] = clientAdd[Client.nameClient.rawValue]
        newOrder[Order.myOrder.rawValue] = PFUser.current()
        newOrder.saveInBackground { (success, error) in
            
            guard let user = PFUser.current(), success else {
                return
            }
            user.relation(forKey: Order.relationForKeyOrders.rawValue).add(newOrder)
            user.saveInBackground()
        }
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

