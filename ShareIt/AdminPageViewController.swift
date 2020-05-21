//
//  AdminPageViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 19.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class AdminPageViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    
        var uid = ""
        var locations = [""]
        let ref = Database.database().reference().child("products")

    
       override func viewDidLoad() {
           super.viewDidLoad()
  
       }
    
   
     
 
}
