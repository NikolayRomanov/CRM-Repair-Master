//
//  DetailsOfServiceVC.swift
//  CRM Repair Master
//
//  Created by Macbook on 15.03.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class DetailsOfServiceVC: UIViewController {
    
    var objectService : PFObject!
    var visibleButtonAddServiceToOrder = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("objectService", objectService)
    }

}
