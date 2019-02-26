//
//  VCCreateClient.swift
//  CRM Repair Master
//
//  Created by Macbook on 24.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit

class CreateAndEditClientVC: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSecondName: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createClient(_ sender: Any) {
        creatNewClient()
        dismiss(animated: true, completion: { })
    }
    
    @IBAction func cancleClient(_ sender: Any) {
        dismiss(animated: true, completion: { })
    }
    
    func creatNewClient() {
        let newClient = Client.init()
        newClient.name = textFieldName.text ?? ""
        newClient.secondName = textFieldSecondName.text ?? ""
        newClient.phonenumber = textFieldPhoneNumber.text ?? ""
        allClients.append(newClient)
    }

}
