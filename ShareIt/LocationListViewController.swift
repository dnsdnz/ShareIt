//
//  LocationListViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 14.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class LocationListViewController: UIViewController {

   let ref = Database.database().reference(withPath: "locations")
    
     /*
    let rootRef = Database.database().reference()

    let childRef = Database.database().reference(withPath: "grocery-items")
    let itemsRef = rootRef.child("grocery-items")
    let milkRef = itemsRef.child("milk")

    print(rootRef.key)   // prints: ""
    print(childRef.key)  // prints: "grocery-items"
    print(itemsRef.key)  // prints: "grocery-items"
    print(milkRef.key)   // prints: "milk"
    
 let saveAction = UIAlertAction(title: "Save",
                                   style: .default) { _ in
        // 1
        guard let textField = alert.textFields?.first,
          let text = textField.text else { return }

        // 2
        let groceryItem = GroceryItem(name: text,
                               addedByUser: self.user.email,
                                 completed: false)
        // 3
        let groceryItemRef = self.ref.child(text.lowercased())

        // 4
        groceryItemRef.setValue(groceryItem.toAnyObject())
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

   

}
