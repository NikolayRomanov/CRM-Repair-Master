//
//  MainVC.swift
//  CRM Repair Master
//
//  Created by Macbook on 03.03.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import Parse

class MainVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        UIColourScheme.instance.set(for: self)
        if PFUser.current() == nil {
            let logInButton = UIBarButtonItem(title: "Login",
                                              style: .plain,
                                              target: self,
                                              action: #selector(showLogInVC))
            navigationItem.leftBarButtonItem = logInButton
        }
        else {
            let logOutButton = UIBarButtonItem(title: "Logout",
                                              style: .plain,
                                              target: self,
                                              action: #selector(showLogOutVC))
            navigationItem.leftBarButtonItem = logOutButton
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func showLogInVC() {
        let logInVC = PFLogInViewController()
        logInVC.delegate = self
        present(logInVC,
                animated: true,
                completion: nil)
    }
    
    @objc func showLogOutVC() {
        let logInVC = PFLogInViewController()
        logInVC.delegate = self
        present(logInVC,
                animated: true,
                completion: nil)
    }
    

}

extension MainVC: PFLogInViewControllerDelegate {
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        logInController.dismiss(animated: true) {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
}
