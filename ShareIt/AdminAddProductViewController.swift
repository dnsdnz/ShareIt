//
//  AdminAddProductViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 19.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AdminAddProductViewController: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var pickerRegion: UIPickerView!
    @IBOutlet weak var pickerCategory: UIPickerView!
    @IBOutlet weak var txtDetail: UITextView!
    
    var ref:DatabaseReference?
    
    var categoryData = CategoryData()
    var regionData = RegionData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        pickerRegion.delegate = regionData
        pickerRegion.dataSource = regionData

        pickerCategory.delegate = categoryData
        pickerCategory.dataSource = categoryData
       
    }

    @IBAction func addButton(_ sender: Any) {
        
        let category = pickerCategory.delegate?.pickerView!(pickerCategory, titleForRow: pickerCategory.selectedRow(inComponent: 0), forComponent: 0)
        let region = pickerRegion.delegate?.pickerView!(pickerRegion, titleForRow: pickerRegion.selectedRow(inComponent: 0), forComponent: 0)
               
        ref?.child("Products").childByAutoId().setValue( ["name":self.txtName.text!,"detail":self.txtDetail.text!,"category":category,"region":region])
        
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButton(_ sender: Any) {
         presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}

class RegionData: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
       
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

   class CategoryData: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
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
