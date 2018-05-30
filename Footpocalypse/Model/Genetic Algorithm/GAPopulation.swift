//
//  GAPopulation.swift
//  Table Clicker
//
//  Created by Matheus Kerber Venturelli on 11/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation

// Class representing the population, it's the core of the genetic algorithm
class GAPopulation {
    var populationSize = 9
    var population: [GAEvolver] = []
    var matingPool: [GAEvolver]?
    
    init(screenSize: GAVector2D, position: GAVector2D, targetPosition: GAVector2D) {
        GAEvolver.screenSize = screenSize
        GAEvolver.targetPosition = targetPosition
        for _ in 0...populationSize {
            self.population.append(GAEvolver(position: position))
        }
    }
    
    // normalizes the population fitness and adds the objects to a mating pool. The objects are added in the mating pool proportionally to the fitness
    func evaluate() {
        var maxfit: Double = 0.0
        
        for i in 0...populationSize {
            population[i].calculateFitness()
            if population[i].fitness! > maxfit {
                maxfit = population[i].fitness!
            }
        }
        for i in 0...populationSize {
            if maxfit != 0 {
                population[i].fitness = population[i].fitness!/maxfit
            }
        }
        
        matingPool = []
        
        for i in 0...populationSize {
            let n = population[i].fitness!*100
            for _ in 0...Int(n) {
                matingPool?.append(population[i])
            }
        }
    }
    
    // joins couples busing the mating pool randomly
    func naturalSelection() {
        for i in 0...populationSize {
            let parentAIndex = arc4random_uniform(UInt32((self.matingPool?.count)! - 1))
            let parentBIntex = arc4random_uniform(UInt32((self.matingPool?.count)! - 1))
            
            let parentA = self.matingPool![Int(parentAIndex)]
            let parentB = self.matingPool![Int(parentBIntex)]
            
            let child = GAEvolver(position: self.population[i].position!)
            
            child.dna.crossOver(parentA: parentA, parentB: parentB)
            
            child.dna.mutation()
            
            self.population[i] = child
        }
    }
}









