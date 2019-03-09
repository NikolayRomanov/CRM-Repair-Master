//
//  Order.swift
//  CRM Repair Master
//
//  Created by Macbook on 04.03.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import Foundation
import Parse

let classNameOrder = "Order"
let orderClassNameClient = "nameClient"
let nameClientOrder = "nameClient"
var globalClient : PFObject!

// for data output PFUser.current()
let myOrder = "MyOrder"
let relationForKeyOrders = "orders"

var objectOrders = [PFObject]()
