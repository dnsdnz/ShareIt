//
//  UserProfileViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 14.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var pickCity: UIPickerView!
    @IBOutlet weak var pickGender: UIPickerView!
    @IBOutlet weak var pickAge: UIPickerView!
    @IBOutlet weak var imgView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
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

       // let storage = Storage.storage()
      
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
        
        var agePickerData = ["18","19","20","21","22","23","24","25","26","27","28","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70"]

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
    
    
    @IBAction func choosePic(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
           self.dismiss(animated: true, completion: { () -> Void in

           })

           imgView.image = image
       }
    
}
