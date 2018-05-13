//
//  GAEvolver.swift
//  Table Clicker
//
//  Created by Matheus Kerber Venturelli on 11/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation

class GAEvolver {
    var dna: GADna = GADna()
    var fitness: Double?
    
    static var screenSize: GAVector2D?
    static var targetPosition: GAVector2D?
    var position: GAVector2D?

    var crashed = false
    var completed = false
    
    init(position: GAVector2D) {
        self.position = position
    }
    
    func update(position: GAVector2D) {
        self.position = position
    }
    
    private func map(minRange:Double, maxRange:Double, minDomain:Double, maxDomain:Double, value:Double) -> Double {
        return minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange)
    }
    
    private func calculateDistance(x1: Double, y1: Double, x2: Double, y2: Double) -> Double {
        return ((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2)).squareRoot()
    }
    
    func calculateFitness() {
        var dist = calculateDistance(x1: (self.position?.x!)!, y1: (self.position?.y!)!, x2: (GAEvolver.targetPosition?.x!)!, y2: (GAEvolver.targetPosition?.y!)!)
        
        if dist > (GAEvolver.screenSize?.x!)! {
            dist = (GAEvolver.screenSize?.x!)!
        }
        // map fitness values
        // scale from 0 to screen height to a scale from screen width to 0
        self.fitness = map(minRange: 0, maxRange: (GAEvolver.screenSize?.x!)!, minDomain: (GAEvolver.screenSize?.x!)!, maxDomain: 0, value: dist)
        
        if self.completed {
            self.fitness = self.fitness!*10
        }
        
        if self.crashed {
            self.fitness = self.fitness!/10
        }
    }
    
    func crash() {
        self.crashed = true
    }
    
    func reachedGoal() {
        self.completed = true
    }
    
    func restart() {
        self.completed = false
        self.crashed = false
    }
}






