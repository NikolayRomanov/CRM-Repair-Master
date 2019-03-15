//
//  VCCreateClient.swift
//  CRM Repair Master
//
//  Created by Macbook on 24.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class CreateAndEditClientVC: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textFieldName.delegate = self
        textFieldPhoneNumber.delegate = self
        textFieldEmail.delegate = self
        textFieldAddress.delegate = self
    }
    
    @IBAction func createClient(_ sender: Any) {
        creatNewClient()
        dismiss(animated: true, completion: { })
    }
    
    @IBAction func cancleClient(_ sender: Any) {
        dismiss(animated: true, completion: { })
    }
    
    func creatNewClient() {
        let newClient = PFObject.init(className: Client.classNameClient.rawValue)
        newClient[Client.nameClient.rawValue] = textFieldName.text
        newClient[Client.phoneNumberClient.rawValue] = textFieldPhoneNumber.text
        newClient[Client.email.rawValue] = textFieldEmail.text
        newClient[Client.address.rawValue] = textFieldAddress.text
        newClient[Client.myClient.rawValue] = PFUser.current()
        newClient.saveInBackground { (success, error) in
            
            guard let user = PFUser.current(), success else {
                return
            }
            user.relation(forKey: Client.relationForKeyClients.rawValue).add(newClient)
            user.saveInBackground()
        }
    }

}

extension CreateAndEditClientVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldName {
            textFieldPhoneNumber.becomeFirstResponder()
        }
        if textField == textFieldPhoneNumber {
            textFieldEmail.becomeFirstResponder()
        }
        if textField == textFieldEmail {
            textFieldAddress.becomeFirstResponder()
        }
        if textField == textFieldAddress {
            textField.resignFirstResponder()
        }
        return false
    }
}
