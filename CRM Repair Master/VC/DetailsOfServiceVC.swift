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
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var buttonAddServiceToOrder: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataToDisplayVC()

        buttonAddServiceToOrder.isHidden = true
        visibleButtonAddService()
        // Do any additional setup after loading the view.
        print("objectService", objectService)
    }
    
    func dataToDisplayVC() {
        textFieldName.text = objectService[Services.name.rawValue] as? String
        textFieldPrice.text = objectService[Services.price.rawValue] as? String
    }
    @IBAction func buttonRBarItemSave(_ sender: Any) {
        objectService[Services.name.rawValue] = textFieldName.text ?? objectService[Services.name.rawValue]
        objectService[Services.price.rawValue] = textFieldPrice.text ?? objectService[Services.price.rawValue]
        objectService.saveInBackground()
    }
    
    @IBAction func buttonAddServiceToOrder(_ sender: Any) {
        globalService = objectService
        dismiss(animated: true, completion: nil)
    }
    
    func visibleButtonAddService() {
        if visibleButtonAddServiceToOrder {
            buttonAddServiceToOrder.isHidden = false
        }
        else {
            return
        }
    }
    
}
