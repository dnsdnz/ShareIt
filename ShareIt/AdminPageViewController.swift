//
//  AdminPageViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 19.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase


class AdminPageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

        
    @IBOutlet weak var tableView: UITableView!
    
    var uid = ""
    var postData = [String]()

    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var productName = ""
   
              
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        databaseHandle =  ref?.child("Products").observe( .childAdded, with: { (snapshot) in
      
    
            let value = snapshot.value as? NSDictionary
            let productName = value?["name"] as? String
   
                       
        if let actualPost = productName{
            self.postData.append(actualPost)
           
            self.tableView.reloadData()
     }
                     })
                     
                     
                 }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
    }
    
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let detail:AdminEditProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdminEditProductViewController") as! AdminEditProductViewController
           
            let productName = postData[indexPath.row]
            detail.productName = productName
             
          
            self.navigationController?.pushViewController(detail, animated: true)
        }
     
     
 
}
