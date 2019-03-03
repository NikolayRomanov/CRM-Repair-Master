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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textFieldName.delegate = self
        textFieldPhoneNumber.delegate = self
    }
    
    @IBAction func createClient(_ sender: Any) {
        creatNewClient()
        dismiss(animated: true, completion: { })
    }
    
    @IBAction func cancleClient(_ sender: Any) {
        dismiss(animated: true, completion: { })
    }
    
    func creatNewClient() {
        let newClient = PFObject.init(className: classNameClient)
        newClient[nameClient] = textFieldName.text
        newClient[phoneNumberClient] = textFieldPhoneNumber.text
        newClient[myClient] = PFUser.current()
        newClient.saveInBackground { (success, error) in
            
            guard let user = PFUser.current(), success else {
                return
            }
            user.relation(forKey: relationForKeyClients).add(newClient)
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
            textField.resignFirstResponder()
        }
        return false
    }
}
