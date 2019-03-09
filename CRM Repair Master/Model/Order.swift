//
//  Order.swift
//  CRM Repair Master
//
//  Created by Macbook on 04.03.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import Foundation
import Parse

enum Order: String {
    case classNameOrder = "Order"
    case clientInOrder = "clientInOrder"
    case nameClientOrder = "nameClient"
    
    // for data output PFUser.current()
    case myOrder = "MyOrder"
    case relationForKeyOrders = "orders"
}

var globalClient : PFObject!

// for data output PFUser.current()
//let myOrder = "MyOrder"
//let relationForKeyOrders = "orders"

var objectOrders = [PFObject]()
