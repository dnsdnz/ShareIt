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

    @IBOutlet weak var textView: UITextView!
    
    var ref:DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

       
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        
        ref?.child("Products").childByAutoId().setValue(textView.text)
        
        
      //  ["password":self.txtPass.text!,"email":self.txtEmail.text!,"role":"U"]
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButton(_ sender: Any) {
         presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
