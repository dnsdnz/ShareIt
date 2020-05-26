//
//  UserProfileViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 14.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var pickCity: UIPickerView!
    @IBOutlet weak var pickGender: UIPickerView!
    @IBOutlet weak var pickAge: UIPickerView!
    
    
     var pickerAgeData: [String] = [String]()
    
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickAge.delegate = self
        self.pickAge.dataSource = self
        
        pickerAgeData = ["18","19", "20", "21", "22", "23"]
      
        let ref = Database.database().reference().child("Users")
        
        ref.child(uid).observeSingleEvent(of: .value){ (snapshot) in
                    
        
            let value = snapshot.value as? NSDictionary
            
            let email = value?["email"] as? String
            let password = value?["password"] as? String
            let name = value?["name"] as? String
            let surname = value?["surname"] as? String
            let phone = value?["phone"] as? String
            let age = value?["age"] as? String
            let gender = value?["gender"] as? String
            let region = value?["region"] as? String

            self.txtEmail.text = email
            self.txtPassword.text = password
            self.txtName.text = name
            self.txtSurname.text = surname
            self.txtPhone.text = phone
            
            
            
        }
    
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return pickerAgeData.count
    }
    

    
    @IBAction func saveInfo(_ sender: Any) {
        
        let ref = Database.database().reference().child("Users")
         
         let email = txtEmail.text
         let name = txtName.text
         let surname = txtSurname.text
         let password = txtPassword.text
         let phone = txtPhone.text
        // let city = pickCity
        // let gender = pickGender
        //let age = pickAge
        
        ref.child(uid).setValue(["name":name,"surname":surname,"region":"Emek","password":password,"age":"22","gender":"female","phone":phone,"role":"U","email":email])
      }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
        let loginPage: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                  
            self.navigationController?.pushViewController(loginPage, animated: true)
    }
    
}
