//
//  MapViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 14.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var uid = ""
    var postData = [String]()
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var dict = [[String:Any]]()

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        ref = Database.database().reference()
           databaseHandle =  ref?.child("Regions").observe( .childAdded, with: { (snapshot) in
                    
          
                   let value = snapshot.value as? NSDictionary
                
                   let title = value?["name"] as! String
                   let latitude = value?["x"] as! Double
                   let longitude = value?["y"] as! Double
                   
            
            self.dict.append(["title" :title, "longitude" : longitude,"latitude" : latitude])
            
         
            self.show_locations(locations : self.dict)
           })
                        
       
                        
                    }
    
    func show_locations(locations : [[String: Any]]){
       print(locations)
        for location in locations{
            let annotations = MKPointAnnotation()
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            annotations.title = location["title"] as? String
            self.mapView.addAnnotation(annotations)
        }
    }
    
    @IBAction func showList(_ sender: Any) {
           let tablePage: LocationListViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationListViewController") as! LocationListViewController
                          
                    self.navigationController?.pushViewController(tablePage, animated: true)
       }
       
       
       
       @IBAction func showProfile(_ sender: Any) {
           let profilePage: UserProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
           
                   profilePage.uid = uid
                          
                    self.navigationController?.pushViewController(profilePage, animated: true)
       }
       
    
}
