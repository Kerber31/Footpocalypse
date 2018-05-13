//
//  Gene.swift
//  Table Clicker
//
//  Created by Matheus Kerber Venturelli on 12/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation

// Class that represents a 2D vector
class GAVector2D {
    var x: Double?
    var y: Double?
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    private func magnitude() -> Double {
        return (self.x!*self.x! + self.y!*self.y!).squareRoot()
    }
    
    func set(length: Double) {
        let magnitude = self.magnitude()
        self.x = (length * self.x!)/magnitude
        self.y = (length * self.y!)/magnitude
    }
}
