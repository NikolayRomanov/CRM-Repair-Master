//
//  VCDetailsOfClient.swift
//  CRM Repair Master
//
//  Created by Macbook on 24.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit

class DetailsOfClientVC: UIViewController {
    
    var clientDetail = Client.init()
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSecondName: UILabel!
    @IBOutlet weak var labelPhoneNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelName.text = clientDetail.name
        labelSecondName.text = clientDetail.secondName
        labelPhoneNumber.text = clientDetail.phonenumber
    }

}
