//
//  LocationDetailViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 27.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class LocationDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
      var postData = [String]()
      var ref:DatabaseReference?
      var databaseHandle:DatabaseHandle?
    
      var locationName = ""
      var locX = 0.0
      var locY = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        txtName.text = locationName
        
             ref = Database.database().reference()
             
             databaseHandle =  ref?.child("Products").observe( .childAdded, with: { (snapshot) in
           
         
                 let value = snapshot.value as? NSDictionary
                 let productRegion = value?["region"] as? String
                 let productName = value?["name"] as? String
        
                            
             if let actualPost = productRegion{
                
                
                if(self.locationName == actualPost){
                    self.postData.append(productName!)
                }
                
                 self.tableView.reloadData()
          }
                          })
                          
                       
                            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell3")
              
              cell?.textLabel?.text = postData[indexPath.row]
              
              return cell!
    }
    
    
    @IBAction func getRoad(_ sender: Any) {
       
       
        let coordinate = CLLocationCoordinate2DMake(locX,locY)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = locationName
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }


    

}
