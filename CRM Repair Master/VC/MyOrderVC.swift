//
//  MyOrderVC.swift
//  CRM Repair Master
//
//  Created by Macbook on 27.02.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class MyOrderVC: UIViewController, UISearchBarDelegate {

    var objectOrders = [PFObject]()
    var searchObjectOrders = [PFObject]()
    var filterObjectStatus = [PFObject]()
    
    typealias EmptyClosure = (() -> Void)
    
    @IBOutlet weak var tableViewOrders: UITableView!
    @IBOutlet weak var searchBarOrder: UISearchBar!
    @IBOutlet weak var segmentStatus: UISegmentedControl!
    
    override func viewDidLoad() {
//        UIColourScheme.instance.set(for: self)
        super.viewDidLoad()
        
        tableViewOrders.dataSource = self
        tableViewOrders.delegate = self
        searchBarOrder.delegate = self
        //reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //reloadData()
        reloadData {
            self.reloadStatusFilter()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let statusOrderFilter = segmentStatus.selectedSegmentIndex
        UserDefaults.standard.set(statusOrderFilter, forKey: "StatusFilter")
        print("statusOrderFilter in viewWillDisappear", statusOrderFilter)
    }
    
    private func reloadData(completion: EmptyClosure? = nil) {
        let query = PFQuery.init(className: Order.classNameOrder.rawValue)
        query.whereKeyExists(Order.myOrder.rawValue)
        query.findObjectsInBackground { (optionalObjects, error) in
            if let realObjects = optionalObjects {
                self.objectOrders = realObjects
                self.searchObjectOrders = self.objectOrders
                //print("print objectClients",objectOrders)
                self.tableViewOrders.reloadData()
                completion?()
            }
        }
    }
    
    @IBAction func segmentStatus(_ sender: Any) {
        filterStatus()
    }
    
    func filterStatus() {
        let getIndex = segmentStatus.selectedSegmentIndex
        print("getIndex", getIndex)
        
        switch getIndex {
        case 0:
            searchObjectOrders = objectOrders
            print("searchObjectOrders", searchObjectOrders.count)
            tableViewOrders.reloadData()
        case 1:
            searchObjectOrders = objectOrders.filter({ (order) -> Bool in
                if order[Order.statusOrder.rawValue] as? Bool == false {
                    return true
                }
                else {
                    return false
                }
            })
            print("searchObjectOrders", searchObjectOrders.count)
            tableViewOrders.reloadData()
        case 2:
            searchObjectOrders = objectOrders.filter({ (order) -> Bool in
                if order[Order.statusOrder.rawValue] as? Bool == true {
                    return true
                }
                else {
                    return false
                }
            })
            print("searchObjectOrders", searchObjectOrders.count)
            tableViewOrders.reloadData()
        default:
            print("No selected Status")
        }
    }
    
    func reloadStatusFilter(){
        if let value = UserDefaults.standard.value(forKey: "StatusFilter") {
            let selectedIndex = value as! Int
            segmentStatus.selectedSegmentIndex = selectedIndex
            filterStatus()
            print("statusOrderFilter in viewWillAppear", selectedIndex)
        }
    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchObjectOrders = objectOrders
            tableViewOrders.reloadData()
            return
        }
        searchObjectOrders = objectOrders.filter({ order -> Bool in
            if let name = order[Order.nameClientOrder.rawValue] as? String {
                return name.contains(searchText)
            }
            else {
                return false
            }
        })
        tableViewOrders.reloadData()
    }
    
}

extension MyOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchObjectOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOrders.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath)
        //searchObjectOrders.reverse()
        let object = searchObjectOrders[indexPath.row]
        let post = object[Order.clientInOrder.rawValue] as! PFObject
        post.fetchIfNeededInBackground { (post: PFObject?, error: Error?) in
            let nameClientObject = post?[Client.nameClient.rawValue] as? String
            cell.textLabel?.text = nameClientObject
        }
        let dateCreate = object.createdAt
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: dateCreate ?? Date())
        cell.detailTextLabel?.text = result
        return cell
    }
}

extension MyOrderVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = searchObjectOrders[indexPath.row]
        performSegue(withIdentifier: "showDetailsOrder", sender: order)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsOrder" {
            if let detailsVC = segue.destination as? DetailsOfOrderVC {
                if let senderOrder = sender as? PFObject {
                    detailsVC.order = senderOrder
                }
            }
        }
    }
}

