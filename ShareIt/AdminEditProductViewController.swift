//
//  AdminEditProductViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 19.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class AdminEditProductViewController: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDetail: UITextView!
    @IBOutlet weak var pickerCat: UIPickerView!
    @IBOutlet weak var pickerRegion: UIPickerView!
    
    var postData = [String]()
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
  
    var productName = ""
    
    var categoryData = CategoryData2()
    var regionData = RegionData2()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerRegion.delegate = regionData
            pickerRegion.dataSource = regionData

            pickerCat.delegate = categoryData
            pickerCat.dataSource = categoryData
        
             ref = Database.database().reference()
             databaseHandle =  ref?.child("Products").observe( .childAdded, with: { (snapshot) in
           
                 let value = snapshot.value as? NSDictionary
                 let productName2 = value?["name"] as? String
        
                            
             if let actualPost = productName2{
                 self.postData.append(actualPost)
                
                if(productName2 == self.productName ){
                  
                    let productDetail = value?["detail"] as? String
                   // let productRegion = value?["region"] as? String
                    //let productCategory = value?["category"] as? String
                    
                    self.txtDetail.text = productDetail
                    self.txtName.text = productName2
                   
                }
                
          }
                          })
                      }
    
    @IBAction func updateProduct(_ sender: Any) {
 
    
    let category = pickerCat.delegate?.pickerView!(pickerCat, titleForRow: pickerCat.selectedRow(inComponent: 0), forComponent: 0)
          let region = pickerRegion.delegate?.pickerView!(pickerRegion, titleForRow: pickerRegion.selectedRow(inComponent: 0), forComponent: 0)
                 
          ref?.child("Products").childByAutoId().setValue( ["name":self.txtName.text!,"detail":self.txtDetail.text!,"category":category,"region":region])
        
          presentingViewController?.dismiss(animated: true, completion: nil)
       }
    }


class RegionData2: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
       
       var regionPickerData = ["İbrahimli", "Karataş","Kalyon","Emek","Akkent","Binevler","Cumhuriyet","Perilikaya","Güneykent","Kavaklık"]
       

       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return regionPickerData.count
       }

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return regionPickerData[row]
       }
   }

   class CategoryData2: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
       var categoryPickerData = ["Clothes", "Electronic","Food","Medicine","Stationery","Furniture","Toy"]

       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return categoryPickerData.count
       }

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return categoryPickerData[row]
       }
   }
    
