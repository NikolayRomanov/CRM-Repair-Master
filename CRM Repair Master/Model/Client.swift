//
//  Client.swift
//  CRM Repair Master
//
//  Created by Macbook on 24.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import Foundation
import Parse

enum Client: String {
    case classNameClient = "Client"
    case nameClient = "name"
    case phoneNumberClient = "phoneNumber"
    
    // for data output PFUser.current()
    case myClient = "MyClient"
    case relationForKeyClients = "clients"
}

//let classNameClient = "Client"
//let nameClient = "name"
//let phoneNumberClient = "phoneNumber"

// for data output PFUser.current()
//let myClient = "MyClient"
//let relationForKeyClients = "clients"

var objectClients = [PFObject]()




