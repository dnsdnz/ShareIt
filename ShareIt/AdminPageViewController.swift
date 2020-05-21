//
//  AdminPageViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 19.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class AdminPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 

    @IBOutlet weak var tableView: UITableView!
    
        var uid = ""
        var locations = ["Ankara","Gaziantep"]
        let ref = Database.database().reference().child("products")

    
       override func viewDidLoad() {
           super.viewDidLoad()
  
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return locations.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductTableViewCell
        
        cell.lblName.text = locations[indexPath.row]
  
        return cell
     }
     
    
   
     
 
}
