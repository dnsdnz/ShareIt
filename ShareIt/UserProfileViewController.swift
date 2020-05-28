//
//  UserProfileViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 14.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var pickCity: UIPickerView!
    @IBOutlet weak var pickGender: UIPickerView!
    @IBOutlet weak var pickAge: UIPickerView!
    
    
    var uid = ""
    
    var ageData = AgeData()
    var genderData = GenderData()
    var regionData = RegionData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickAge.delegate = ageData
        pickAge.dataSource = ageData

        pickGender.delegate = genderData
        pickGender.dataSource = genderData

        pickCity.delegate = regionData
        pickCity.dataSource = regionData

      
        let ref = Database.database().reference().child("Users")
        
        ref.child(uid).observeSingleEvent(of: .value){ (snapshot) in
                    
        
            let value = snapshot.value as? NSDictionary
            
            let email = value?["email"] as? String
            let password = value?["password"] as? String
            let name = value?["name"] as? String
            let surname = value?["surname"] as? String
            let phone = value?["phone"] as? String

            self.txtEmail.text = email
            self.txtPassword.text = password
            self.txtName.text = name
            self.txtSurname.text = surname
            self.txtPhone.text = phone
          
        }
    
    }


    class AgeData: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var agePickerData = ["18", "19", "20", "21", "22", "23","24","25","26"]
        
        

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return agePickerData.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return agePickerData[row]
        }
    }

    class GenderData: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var genderPickerData = ["Female", "Male"]

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return genderPickerData.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return genderPickerData[row]
        }
    }
    

    
    class RegionData: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
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
    

    
    @IBAction func saveInfo(_ sender: Any) {
        
        let ref = Database.database().reference().child("Users")
         
         let email = txtEmail.text
         let name = txtName.text
         let surname = txtSurname.text
         let password = txtPassword.text
         let phone = txtPhone.text
        
        let age = pickAge.delegate?.pickerView!(pickAge, titleForRow: pickAge.selectedRow(inComponent: 0), forComponent: 0)
        let gender = pickGender.delegate?.pickerView!(pickGender, titleForRow: pickGender.selectedRow(inComponent: 0), forComponent: 0)
        let region = pickCity.delegate?.pickerView!(pickCity, titleForRow: pickCity.selectedRow(inComponent: 0), forComponent: 0)
        
        ref.child(uid).setValue(["name":name,"surname":surname,"region":region,"password":password,"age":age,"gender":gender,"phone":phone,"role":"U","email":email])
      }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
        let loginPage: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                  
            self.navigationController?.pushViewController(loginPage, animated: true)
    }
    
}
