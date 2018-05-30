//
//  StoreItem.swift
//  Footpocalypse
//
//  Created by Matheus Kerber Venturelli on 16/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation

struct StoreItem {
    var name: String
    var price: Int
    var imageName: String
    var shortDescription: String
    var detailedDescription: String
    var spriteImageName: String
    
    init(name: String, shortDescription: String, detailedDescription: String, imageName: String, price: Int, spriteImageName: String) {
        self.name = name
        self.price = price
        self.imageName = imageName
        self.shortDescription = shortDescription
        self.detailedDescription = detailedDescription
        self.spriteImageName = spriteImageName
    }
}
