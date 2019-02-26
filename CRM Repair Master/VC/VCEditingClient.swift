//
//  VCEditingClient.swift
//  CRM Repair Master
//
//  Created by Macbook on 24.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit

class VCEditingClient: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneEditingClient(_ sender: Any) {
        dismiss(animated: true, completion: { })
    }
    
    @IBAction func cancelEditingClient(_ sender: Any) {
        dismiss(animated: true, completion: { })
    }
    
}
