//
//  LocationDetailViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 27.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class LocationDetailViewController: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    
      var postData = [String]()
      var ref:DatabaseReference?
      var databaseHandle:DatabaseHandle?
    
      var locationName = ""
    
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
                    
                      let locationX = value?["x"] as! Double
                      let locationY = value?["y"] as! Double
                      
                    print(locationX)
                    print(locationY)
                   
                    self.txtName.text = locationName2
                
                  }
                  
                  
           
            }
                            })
                            
    }
    


}
