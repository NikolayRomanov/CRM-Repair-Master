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
    case servicesInOrder = "servicesInOrder"
    case nameClientOrder = "nameClient"
    case comments = "comments"
    case statusOrder = "statusOrder"
    
    // for data output PFUser.current()
    case myOrder = "MyOrder"
    case relationForKeyOrders = "orders"
}

var globalClient : PFObject!
var globalService : PFObject!


