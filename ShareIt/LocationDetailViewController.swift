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

class LocationDetailViewController: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    
      var postData = [String]()
      var ref:DatabaseReference?
      var databaseHandle:DatabaseHandle?
    
      var locationName = ""
      var locX = 0.0
      var locY = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(locationName)
        
             ref = Database.database().reference()
               databaseHandle =  ref?.child("Regions").observe( .childAdded, with: { (snapshot) in
             
                   let value = snapshot.value as? NSDictionary
                   let locationName2 = value?["name"] as? String
          
                              
               if let actualPost = locationName2{
                   self.postData.append(actualPost)
                  
                  if(locationName2 == self.locationName ){
                    
                    self.locX = value?["x"] as! Double
                    self.locY = value?["y"] as! Double
                      
                    print(self.locX)
                    print(self.locY)
                   
                    self.txtName.text = locationName2
                
                  }
                  
            }
                            })
                            
    }
    
    @IBAction func getRoad(_ sender: Any) {
       
       
        let coordinate = CLLocationCoordinate2DMake(locX,locY)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = locationName
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    


}
