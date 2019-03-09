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
    
    @IBOutlet weak var labelNameClient: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addClient()
    }
    
    func addClient() {
        if let client = globalClient {
            clientAdd = client
            globalClient = nil
            labelNameClient.text = clientAdd[Client.nameClient.rawValue] as? String
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
    }
}

