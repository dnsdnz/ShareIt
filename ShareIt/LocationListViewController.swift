//
//  LocationListViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 14.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class LocationListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
       var uid = ""
       var postData = [String]()

       var ref:DatabaseReference?
       var databaseHandle:DatabaseHandle?
       
     var locationName = ""
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           tableView.delegate = self
           tableView.dataSource = self
           
           ref = Database.database().reference()
           
           databaseHandle =  ref?.child("Regions").observe( .childAdded, with: { (snapshot) in
           
               let value = snapshot.value as? NSDictionary
               
               let locationName = value?["name"] as? String
                         
                          
           if let actualPost = locationName{
               self.postData.append(actualPost)
              
               self.tableView.reloadData()
           }
           })
           
       }
      
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return postData.count
       }
    
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
           
           cell?.textLabel?.text = postData[indexPath.row]
           
           return cell!
       }
         
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
                let detail:LocationDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationDetailViewController") as! LocationDetailViewController
               
                let locationName = postData[indexPath.row]
                detail.locationName = locationName
              
                self.navigationController?.pushViewController(detail, animated: true)
            }
    
   
    }
    

   
