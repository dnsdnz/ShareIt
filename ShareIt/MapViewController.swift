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

class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
   var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
