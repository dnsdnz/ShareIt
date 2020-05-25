//
//  AdminPageViewController.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 19.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import UIKit
import Firebase

class AdminPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 

    @IBOutlet weak var tableView: UITableView!

    
        var uid = ""
    
    
    //defining firebase reference var
    var refArtists: DatabaseReference!
        
       
        //list to store all the artist
        var artistList = [LocationModel]()
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return artistList.count
        }
        
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            //creating a cell using the custom class
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
            
            //the artist object
            let artist: LocationModel
            
            //getting the artist of selected position
            artist = artistList[indexPath.row]
            
            //adding values to labels
            cell.lblName.text = artist.name
           
           // cell.labelGenre.text = artist.genre
            
            //returning cell
            return cell
        }
        
    
        
        override func viewDidLoad() {
            super.viewDidLoad()

                   
            refArtists = Database.database().reference().child("products");
                   
                   //observing the data changes
            refArtists.observe(DataEventType.value, with: { (snapshot) in
                       
                       //if the reference have some values
                       if snapshot.childrenCount > 0 {
                           
                           //clearing the list
                           self.artistList.removeAll()
                           
                           //iterating through all the values
                        for artists in snapshot.children.allObjects as! [DataSnapshot] {
                               //getting values
                               let artistObject = artists.value as? [String: AnyObject]
                               let artistName  = artistObject?["name"]
                               let artistId  = artistObject?["id"]
                               let artistGenre = artistObject?["detail"]
                               
                               //creating artist object with model and fetched values
                               let artist = LocationModel(id: artistId as! String?, name: artistName as! String?, genre: artistGenre as! String?)
                               
                               //appending it to list
                               self.artistList.append(artist)
                            print(artistName)
                           }
                           
                           //reloading the tableview
                         
                       }
                   })
                   
               }
        
        
    

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }


    }
    
    
     

