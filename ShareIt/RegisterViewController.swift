//
//  RegisterViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 7.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtPassConf: UITextField!
    
     var ref:DatabaseReference?
    
    
    @IBAction func registerButton(_ sender: Any) {
        
        if txtPass.text != txtPassConf.text {
        let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
                }
        else{
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPass.text!){ (user, error) in
         if error == nil {
            
            let user = Auth.auth().currentUser
            let uid = user!.uid
            
           
            self.ref = Database.database().reference()

            self.ref?.child("Users").child(uid).setValue(["password":self.txtPass.text!,"email":self.txtEmail.text!,"role":"U"])
            
           let logPage: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
           
           self.navigationController?.pushViewController(logPage, animated: true)
                        }
            
         else{
           let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
           let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
               }
                    }
              }
        
    }
    
    
    @IBAction func goLogin(_ sender: Any) {
        let loginPage: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                  
            self.navigationController?.pushViewController(loginPage, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

