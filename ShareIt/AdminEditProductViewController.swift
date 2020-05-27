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
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtRegion: UITextField!
    @IBOutlet weak var txtDetail: UITextView!
    
    var postData = [String]()
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
  
    var productName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
             ref = Database.database().reference()
             databaseHandle =  ref?.child("Products").observe( .childAdded, with: { (snapshot) in
           
                 let value = snapshot.value as? NSDictionary
                 let productName2 = value?["name"] as? String
        
                            
             if let actualPost = productName2{
                 self.postData.append(actualPost)
                
                if(productName2 == self.productName ){
                  
                    let productDetail = value?["detail"] as? String
                    let productRegion = value?["region"] as? String
                    let productCategory = value?["category"] as? String
                    
                    self.txtDetail.text = productDetail
                    self.txtName.text = productName2
                    self.txtCategory.text = productCategory
                    self.txtRegion.text = productRegion
                }
                
                
         
          }
                          })
                          
                          
                      }
   

    }
    
