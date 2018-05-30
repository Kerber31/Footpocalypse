//
//  GAEvolver.swift
//  Table Clicker
//
//  Created by Matheus Kerber Venturelli on 11/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation

// class used to calculate the fitness of the objects that are being trained
class GAEvolver {
    var dna: GADna = GADna()
    var fitness: Double?
    
    // bounds of the screen and  position of the target are used to calculate the fitness
    static var screenSize: GAVector2D?
    static var targetPosition: GAVector2D?
    var position: GAVector2D?
    
    var crashed = false
    var completed = false
    
    // initializes with an initial position
    init(position: GAVector2D) {
        self.position = position
    }
    
    // update the position based on the objects on GameScene
    func update(position: GAVector2D) {
        self.position = position
    }
    
    // map a value from a number range to another
    private func map(minRange:Double, maxRange:Double, minDomain:Double, maxDomain:Double, value:Double) -> Double {
        return minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange)
    }
    
    // Calculates the fitness. Higher itnesses are better.
    func calculateFitness() {
        var dist = self.position?.calculateDistanceTo(vector: GAEvolver.targetPosition!)
        
        if dist! > (GAEvolver.screenSize?.x!)! {
            dist = (GAEvolver.screenSize?.x!)!
        }
        // map fitness values
        // scale from 0 to screen height to a scale from screen width to 0
        self.fitness = map(minRange: 0, maxRange: (GAEvolver.screenSize?.x!)!, minDomain: (GAEvolver.screenSize?.x!)!, maxDomain: 0, value: dist!)
        
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






