//
//  CreateNewServiceVC.swift
//  CRM Repair Master
//
//  Created by Macbook on 13.03.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class CreateNewServiceVC: UIViewController {
    
    @IBOutlet weak var textFieldPriceService: UITextField!
    @IBOutlet weak var textFieldNameService: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createClient(_ sender: Any) {
        creatNewSrevice()
        dismiss(animated: true, completion: { })
    }
    
    @IBAction func cancleClient(_ sender: Any) {
        dismiss(animated: true, completion: { })
    }
    
    func creatNewSrevice() {
        let newService = PFObject.init(className: Services.classNameServices.rawValue)
        newService[Services.name.rawValue] = textFieldNameService.text

        newService[Services.price.rawValue] = textFieldPriceService.text
        newService[Services.myServices.rawValue] = PFUser.current()
        newService.saveInBackground { (success, error) in
            
            guard let user = PFUser.current(), success else {
                return
            }
            user.relation(forKey: Services.relationForKeyServices.rawValue).add(newService)
            user.saveInBackground()
        }
    }

}
