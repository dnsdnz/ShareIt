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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(uid)
      
        let ref = Database.database().reference().child("users")
        
        ref.child(uid).observeSingleEvent(of: .value){ (snapshot) in
                    
        
            let value = snapshot.value as? NSDictionary

            let email = value?["name"] as? String
            let password = value?["password"] as? String
            
            self.txtEmail.text = email
            self.txtPassword.text = password
            
            
        }

        // ref.child("1/name").setValue("DenizC")  //change value in database
        
      /*  ref.childByAutoId().setValue(["name":"BDeniz","surname":"Cakmaz","city":"Gaziantep","password":"12345678","email":"mail@mail.com","age":"21","gender":"female","role":"U","phone":"12345678"])
        
            */   //Add new user
       
     /*
        */         //read data from firebase
        
        
       // ref.child("1").removeValue()
    
            //delete data from firebase
    
    }
    
    @IBAction func saveInfo(_ sender: Any) {
        
        let ref = Database.database().reference().child("users")
         
         let name = txtName.text
         let surname = txtSurname.text
         let password = txtPassword.text
         let phone = txtPhone.text
        // let city = pickCity
        // let gender = pickGender
        //let age = pickAge
        
        ref.child(uid).setValue(["name":name,"surname":surname,"city":"Gaziantep","password":password,"age":"21","gender":"female","phone":phone])
      }
      
}
