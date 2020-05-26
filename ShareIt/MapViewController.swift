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
          
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let ref = Database.database().reference()
           ref.child("Regions").observeSingleEvent(of: .childAdded){ (snapshot) in
                       
           
               let value = snapshot.value as? NSDictionary
               
               let title = value?["name"] as? String
               let latitude = value?["x"] as? String
               let longitude = value?["y"] as? String
                  

                 let annotation = MKPointAnnotation()
                 annotation.coordinate = CLLocationCoordinate2D(latitude: (Double(latitude!))!, longitude: (Double(longitude!))!)
                 annotation.title = title
                 self.mapView.addAnnotation(annotation)
               
               
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
