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

    
        var post = [String]()
        var uid = ""
        var locations = ["Ankara","Gaziantep"]
        let ref = Database.database().reference()

    
       override func viewDidLoad() {
           super.viewDidLoad()
        
    
     ref.child("products").child("name").observe(.childAdded) { (snapshot) in
        print("\((snapshot.value as? NSDictionary)!)")
        self.tableView.reloadData()
      }
        
        
        
        /*        ref.child(uid).observeSingleEvent(of: .value){ (snapshot) in
                         
                             let value = snapshot.value as? NSDictionary
                             let productId = value?["name"] as? String
                 
                         } */
  
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return post.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductTableViewCell
        
        cell.lblName.text = post[indexPath.row]
  
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           let detail:AdminEditProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdminEditProductViewController") as! AdminEditProductViewController
          
            detail.productID = post[indexPath.row]
         
           self.navigationController?.pushViewController(detail, animated: true)
       }
     
    
   
     
 
}
