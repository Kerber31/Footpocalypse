//
//  GADna.swift
//  Table Clicker
//
//  Created by Matheus Kerber Venturelli on 12/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation

// Class that describes the genetic algorithm's DNA
class GADna {
    var genes: [GAVector2D] = []
    static var dnaSize: Int = 200
    
    // initializes the genes with random vectors that will be used to move the objects that are being trained
    init() {
        for i in 0...GADna.dnaSize {
            let randomChance = arc4random_uniform(2)
            
            if randomChance == 0 {
                genes.append(GAVector2D(x: Double(arc4random_uniform(10)), y: Double(arc4random_uniform(10))))
            }
            else if randomChance == 1{
                genes.append(GAVector2D(x: Double(arc4random_uniform(10)), y: -Double(arc4random_uniform(10))))
            }
//            if randomChance == 2 {
//                genes.append(GAVector2D(x: -Double(arc4random_uniform(10)), y: Double(arc4random_uniform(10))))
//            }
//            else {
//                genes.append(GAVector2D(x: -Double(arc4random_uniform(10)), y: -Double(arc4random_uniform(10))))
//            }
            
            self.genes[i].set(length: 4.5)
        }
    }
    
    // the crossOver function receives two GAEvolvers and transforms self's genes in half parentA's genes and half parentB's genes
    func crossOver(parentA: GAEvolver, parentB: GAEvolver) {
        for i in 0...GADna.dnaSize {
            if i <= self.genes.count/2{
                self.genes[i] = parentA.dna.genes[i]
            }
            else {
                self.genes[i] = parentB.dna.genes[i]
            }
        }
    }
    
    // the mutation function randomly mutates self's genes, on a 3 percent chance
    func mutation() {
        for i in 0...GADna.dnaSize {
            if Double(arc4random_uniform(100))/100 < 0.03 {
                let randomChance = arc4random_uniform(2)
                
                if randomChance == 0 {
                    self.genes[i] = GAVector2D(x: Double(arc4random_uniform(10)), y: Double(arc4random_uniform(10)))
                }
                else if randomChance == 1 {
                    self.genes[i] = GAVector2D(x: Double(arc4random_uniform(10)), y: -Double(arc4random_uniform(10)))
                }
//                else if randomChance == 2 {
//                    self.genes[i] = GAVector2D(x: -Double(arc4random_uniform(10)), y: -Double(arc4random_uniform(10)))
//                }
//                else {
//                    self.genes[i] = GAVector2D(x: -Double(arc4random_uniform(10)), y: Double(arc4random_uniform(10)))
//                }
                
                self.genes[i].set(length: 4.5)
            }
        }
    }
}
















