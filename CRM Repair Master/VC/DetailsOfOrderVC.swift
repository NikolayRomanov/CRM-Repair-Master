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
    }
    
    @IBAction func switchStatusOrder(_ sender: Any) {
    }
    
}
