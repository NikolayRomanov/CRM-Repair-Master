//
//  VCDetailsOfClient.swift
//  CRM Repair Master
//
//  Created by Macbook on 24.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class DetailsOfClientVC: UIViewController {
    
    var clientDetail : PFObject!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textFieldName.text = clientDetail[nameClient] as? String
        textFieldPhoneNumber.text = clientDetail[phoneNumberClient] as? String

        textFieldName.delegate = self
        textFieldPhoneNumber.delegate = self
    }
    
    @IBAction func saveClient(_ sender: Any) {
        clientDetail[nameClient] = textFieldName.text ?? clientDetail[nameClient]
        clientDetail[phoneNumberClient] = textFieldPhoneNumber.text ?? clientDetail[phoneNumberClient]
        clientDetail.saveInBackground()
    }
    
    @IBAction func buttonAddClientToOrder(_ sender: Any) {
        /*let userDefaults = UserDefaults.standard
        userDefaults.set(clientDetail.objectId, forKey: "addClientToOrder")
        print("clientDetail[objectIdClassClient]", clientDetail.objectId!)*/
        globalClient = clientDetail
        //print("globalClient", globalClient)
        dismiss(animated: true, completion: nil)
    }
}

extension DetailsOfClientVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldName {
            textFieldPhoneNumber.becomeFirstResponder()
        }
        if textField == textFieldPhoneNumber {
            textField.resignFirstResponder()
        }
        return false
    }
}
