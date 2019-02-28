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
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSecondName: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textFieldName.text = clientDetail.name
        textFieldSecondName.text = clientDetail.secondName
        textFieldPhoneNumber.text = clientDetail.phonenumber
        
        textFieldName.delegate = self
        textFieldSecondName.delegate = self
        textFieldPhoneNumber.delegate = self
    }
    
    @IBAction func saveClient(_ sender: Any) {
        clientDetail.name = textFieldName.text ?? clientDetail.name
        clientDetail.secondName = textFieldSecondName.text ?? clientDetail.secondName
        clientDetail.phonenumber = textFieldPhoneNumber.text ?? clientDetail.phonenumber
    }
    
    @IBAction func buttonDissmis(_ sender: Any) {
        dismiss(animated: true, completion: { })
    }
}

extension DetailsOfClientVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldName {
            textFieldSecondName.becomeFirstResponder()
        }
        if textField == textFieldSecondName {
            textFieldPhoneNumber.becomeFirstResponder()
        }
        if textField == textFieldPhoneNumber {
            textField.resignFirstResponder()
        }
        return false
    }
}
