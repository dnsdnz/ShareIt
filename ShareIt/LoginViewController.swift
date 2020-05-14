//
//  LoginViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 7.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
   
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: mailText.text!, password: passText.text!) { (user, error) in
           if error == nil{
             self.performSegue(withIdentifier: "MapViewController", sender: self)
                          }
            else{
             let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
              alertController.addAction(defaultAction)
              self.present(alertController, animated: true, completion: nil)
                 }
        }
    }
    
    
    @IBAction func goRegister(_ sender: Any) {
        
        let regPage: RegisterViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            
            self.navigationController?.pushViewController(regPage, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    



}
