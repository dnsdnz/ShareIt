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
    
  struct jsonstruct:Decodable {
      let id:Int
      let adi:String
      let aciklama:String
      let x:String
      let y:String
      let adres:String
      let link:String
      let iptal:Int
      
  }

  var locationManager:CLLocationManager!
  var locManager = CLLocationManager()
  var currentCoordinate: CLLocationCoordinate2D!




  var images = ["rektorluk", "kkm", "kkm","library","rektörlük","rektörlük","rektörlük","rektörlük", "rektörlük","rektörlük","rektörlük","rektörlük","rektörlük","rektörlük","rektörlük","rektörlük","rektörlük","rektörlük",
                "rektörlük","rektörlük","rektörlük","rektörlük","rektörlük","rektörlük"]

  var imgArr = ["https://portal.hku.edu.tr/MobilKampus/4-2.jpg","https://portal.hku.edu.tr/MobilKampus/4-1.jpg"]


  var xLoc = 0.0
  var yLoc = 0.0

  let regionInMeters: Double = 10000

      var arrdata = [jsonstruct]()
       var currentjson = [jsonstruct]() //update table

      var curX = ""
      var curY = ""

      var locID = 1
      var locX = 0.0
      var locY = 0.0
      var locName = ""
      var locContent = ""
      var locLink = ""
      var locAddress = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          // mapView.mapType = .satellite
              
              getdata()
              
              mapView.showsUserLocation = true
              locManager.requestWhenInUseAuthorization()  //LOCATION
              
              if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                  CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
                  guard let currentLocation = locManager.location else {
                      return
                  }
                  
                  curX = String(currentLocation.coordinate.latitude)
                  curY = String(currentLocation.coordinate.longitude)
                  
                  print(curX)
                  print(curY)
              }
        
        
        

    }
    
     func setMap(locId : Int, locaX : Double, locaY : Double,locNameMap : String,locConMap : String) {
            
            
            DispatchQueue.main.async{
                
          
                print(locId)
                print(locNameMap)
                print(locaX)
             
                print(locaY)
                print("  ")
                
              
                self.locY = locaY
                self.locX = locaX
                self.locName = locNameMap
                self.locContent = locConMap
                self.locID = locId
             
                
                let destinationLocation = CLLocationCoordinate2D(latitude:self.locX, longitude:self.locY)
                
                let destinationAnnotation = MKPointAnnotation()
            
                
                destinationAnnotation.title = self.locName
                
                destinationAnnotation.coordinate = destinationLocation
                
                self.mapView.view(for: destinationAnnotation)
                
                self.mapView.showAnnotations([destinationAnnotation], animated: true )
                self.mapView.addAnnotation(destinationAnnotation)
                
               
            }
        }
        
        func setupLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        
        func centerViewOnUserLocation() {
            
            if let location = locationManager.location?.coordinate {
                
                let regionInMeters: Double = 1.9
               let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            
                mapView.setRegion(region, animated: true)
                
            }
        }
        
        
        func checkLocationServices() {
            if CLLocationManager.locationServicesEnabled() {
                setupLocationManager()
                checkLocationAuthorization()
            } else {
                // Show alert letting the user know they have to turn this on.
            }
        }
        
        
        func checkLocationAuthorization() {
            
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                centerViewOnUserLocation()
                locationManager.startUpdatingLocation()
                break
            case .denied:
                // Show alert instructing them how to turn on permissions
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                // Show an alert letting them know what's up
                break
            case .authorizedAlways:
                break
                
            @unknown default: break
                
            }
        }
        
    }

    extension MapViewController: CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
        {
            print("Error \(error)")
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
    }

    extension MapViewController: MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let annotationView = MKAnnotationView(annotation:annotation, reuseIdentifier:locName)
            
            if annotation is MKUserLocation { return nil }
            
            if annotation.title == "Rektörlük" || annotation.title == "Bilgi İşlem Müdürlüğü" || annotation.title == "Basın Halkla İlişkiler Müdürlüğü" ||
                annotation.title == "Destek Hizmetleri Müdürlüğü" || annotation.title == "Personel Müdürlüğü" || annotation.title == "Mali İşler ve Satın Alma Müdürlüğü"
            {
                let pinImage = UIImage(named: "adminis")
                let size = CGSize(width: 50, height: 50)
                UIGraphicsBeginImageContext(size)
                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                
                
                annotationView.tag = locID
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                
                annotationView.image = resizedImage
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                
                return annotationView
            }
                
            else if(annotation.title == "Mühendislik Fakültesi" || annotation.title == "Hukuk Fakültesi" || annotation.title == "İktisadi İdari Bİlimler Fakültesi" || annotation.title == "Yabancı Diller"){
                
                let pinImage = UIImage(named: "faculty")
                let size = CGSize(width: 50, height: 50)
                UIGraphicsBeginImageContext(size)
                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                
                
                annotationView.tag = locID
             
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                
                annotationView.image = resizedImage
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                
                return annotationView
            }
                
            else if(annotation.title == "Mühendislik Fakültesi" || annotation.title == "Hukuk Fakültesi" || annotation.title == "İktisadi İdari Bİlimler Fakültesi" || annotation.title == "Yabancı Diller"){
                
                let pinImage = UIImage(named: "faculty")
                let size = CGSize(width: 50, height: 50)
                UIGraphicsBeginImageContext(size)
                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                
                
                annotationView.tag = locID
                
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                
                annotationView.image = resizedImage
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                
                return annotationView
            }
                
            else if(annotation.title == "Yemekhane"  || annotation.title == "Etiler Marmaris" || annotation.title == "Teras Restaurant" ||
                annotation.title == "Lavazza" || annotation.title == "Sultanahmet Köftecisi" || annotation.title == "Starbucks"){
                
                let pinImage = UIImage(named: "food")
                let size = CGSize(width: 50, height: 50)
                UIGraphicsBeginImageContext(size)
                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                
                
                annotationView.tag = locID
                
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                
                annotationView.image = resizedImage
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                
                return annotationView
            }
                
            else if(annotation.title == "Kongre ve Kültür Merkezi"  || annotation.title == "Kütüphane"){
                
                let pinImage = UIImage(named: "culture")
                let size = CGSize(width: 50, height: 50)
                UIGraphicsBeginImageContext(size)
                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                
                
                annotationView.tag = locID
                
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                
                annotationView.image = resizedImage
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                
                return annotationView
            }
                
            else if(annotation.title == "KYK Yurdu"){
                
                let pinImage = UIImage(named: "dorm")
                let size = CGSize(width: 50, height: 50)
                UIGraphicsBeginImageContext(size)
                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                
                
                annotationView.tag = locID
                
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                
                annotationView.image = resizedImage
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                
                return annotationView
            }
                
            else{
                let pinImage = UIImage(named: "tech")
                let size = CGSize(width: 50, height: 50)
                UIGraphicsBeginImageContext(size)
                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                
                annotationView.tag = locID
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                
                annotationView.image = resizedImage
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                
                
                return annotationView
            }
            
        }
        
      /*  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            let info: CaroViewController = self.storyboard?.instantiateViewController(withIdentifier: "CaroViewController") as! CaroViewController
            
            self.navigationController?.pushViewController(info, animated: true)
       
        }  */
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
        {
            let tag = view.tag
            print(tag)
            locID = tag
           
        }

        
      
    
    
    func getdata(){
        let url = URL(string: "https://portal.hku.edu.tr/api/MobilKampus")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                if error == nil{
                    
                    self.arrdata = try JSONDecoder().decode([jsonstruct].self, from: data!)
                    
                    var i = 0
                    
                    for _ in self.arrdata{
                        
                        DispatchQueue.main.async {
                            self.setMap(locId: self.arrdata[i].id, locaX: Double(self.arrdata[i].x)! , locaY: Double(self.arrdata[i].y)! , locNameMap: self.arrdata[i].adi, locConMap: self.arrdata[i].aciklama)
                           
                            i = i+1
                        }
                        
                    }
                }
            }
            catch{
                print(error)
            }
            }.resume()
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
