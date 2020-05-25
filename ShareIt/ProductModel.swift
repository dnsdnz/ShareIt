//
//  ProductModel.swift
//  ShareIt
//
//  Created by Deniz MacBook Air on 25.05.2020.
//  Copyright © 2020 Deniz Cakmak. All rights reserved.
//

import Foundation


class ProductModel {
        
        var id: String?
        var name: String?
        var category: String?
        var detail: String?
        var location: String?
    
        
        init(id: String?, name: String?, category: String?, detail: String?, location: String?){
            self.id = id
            self.name = name
            self.category = category
            self.detail = detail
            self.location = location
        }
    }

