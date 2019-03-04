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
        let userDefaults = UserDefaults.standard
        if let objectId = userDefaults.string(forKey: "addClientToOrder") {
            print("objectId", objectId)
            labelNameClient.text = objectId
        }
        else {
            print("addClient() in else")
            return
        }
    }

    @IBAction func rightBarButtonDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftBarButtonCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonAddClient(_ sender: Any) {
    }
}

