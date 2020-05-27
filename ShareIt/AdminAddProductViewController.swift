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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

       
    }

    @IBAction func addButton(_ sender: Any) {
        
        
        ref?.child("Products").childByAutoId().setValue( ["name":self.txtName.text!,"detail":self.txtDetail.text!,"category":"Clothes","region":"Karatas"])
        
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButton(_ sender: Any) {
         presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
