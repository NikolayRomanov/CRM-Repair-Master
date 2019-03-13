//
//  MyServicesVC.swift
//  
//
//  Created by Macbook on 12.03.2019.
//

import UIKit
import Parse

class MyServicesVC: UIViewController {
    
    var addServices = false
    var objectServices = [PFObject]()
    @IBOutlet weak var tableViewMyServices: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewMyServices.dataSource = self
        //tableViewMyServices.delegate = self

        // Do any additional setup after loading the view.
        print("addServices", addServices)
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func reloadData() {
        
        let query = PFQuery.init(className: Services.classNameServices.rawValue)
        query.whereKeyExists(Services.myServices.rawValue)
        query.findObjectsInBackground { (optionalObjects, error) in
            if let realObjects = optionalObjects {
                self.objectServices = realObjects
                print("print objectClients", self.objectServices)
                self.tableViewMyServices.reloadData()
            }
        }
    }

    @IBAction func buttonAddNewServices(_ sender: Any) {
    }
}

extension MyServicesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMyServices", for: indexPath)
        let objectToDisplay = objectServices[indexPath.row]
        cell.textLabel?.text = objectToDisplay[Services.name.rawValue] as? String
        cell.detailTextLabel?.text = objectToDisplay[Services.price.rawValue] as? String
        
        return cell
    }
    
}

extension MyServicesVC: UITableViewDelegate {
    
}
