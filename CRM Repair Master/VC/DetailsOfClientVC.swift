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
    
    var visibleButtonAddClientToOrder = false
    var clientDetail : PFObject!
    
    @IBOutlet weak var buttonOutletAddClientToOrder: UIButton!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textFieldName.text = clientDetail[Client.nameClient.rawValue] as? String
        textFieldPhoneNumber.text = clientDetail[Client.phoneNumberClient.rawValue] as? String
        textFieldEmail.text = clientDetail[Client.email.rawValue] as? String
        textFieldAddress.text = clientDetail[Client.address.rawValue] as? String
        
        buttonOutletAddClientToOrder.isHidden = true
        visibleButtonAddClient()
        print("visibleButtonAddClientToOrder",visibleButtonAddClientToOrder)
        textFieldName.delegate = self
        textFieldPhoneNumber.delegate = self
    }
    
    @IBAction func saveClient(_ sender: Any) {
        clientDetail[Client.nameClient.rawValue] = textFieldName.text ?? clientDetail[Client.nameClient.rawValue]
        clientDetail[Client.phoneNumberClient.rawValue] = textFieldPhoneNumber.text ?? clientDetail[Client.phoneNumberClient.rawValue]
        clientDetail[Client.email.rawValue] = textFieldEmail.text ?? clientDetail[Client.email.rawValue]
        clientDetail[Client.address.rawValue] = textFieldEmail.text ?? clientDetail[Client.address.rawValue]
        clientDetail.saveInBackground()
    }
    
    @IBAction func buttonAddClientToOrder(_ sender: Any) {
        globalClient = clientDetail
        dismiss(animated: true, completion: nil)
    }
    
    func visibleButtonAddClient() {
        if visibleButtonAddClientToOrder {
            buttonOutletAddClientToOrder.isHidden = false
        }
        else {
            return
        }
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
