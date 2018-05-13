//
//  GameScene.swift
//  Footpocalypse
//
//  Created by Matheus Kerber Venturelli on 08/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var wall: SKSpriteNode?
    private var darts : [SKSpriteNode]? = []
    private var crashed: [Bool]? = []
    private var target: SKSpriteNode?
    private var enemyes: [SKSpriteNode]?
    private var initialDartsPosition: GAVector2D?
    private var targetPosition: GAVector2D?
    private var population: GAPopulation?
    private var presentFrame: Int = 0
    
    private var dartsKilled = 0
    
    enum ColliderType:UInt32 {
        case foot = 1
        case enemy = 2
        case target = 4
        case wall = 8
    }
    
    override func didMove(to view: SKView) {
        let screenSize = GAVector2D(x: Double(self.frame.width), y: Double(self.frame.height))
        self.initialDartsPosition = GAVector2D(x: -Double(self.frame.width/2 - 45), y: 0)
        self.targetPosition = GAVector2D(x: -Double(self.frame.width/2), y: 0)
        
        self.population = GAPopulation(screenSize: screenSize, position: self.initialDartsPosition!, targetPosition: self.targetPosition!)
        
        physicsWorld.contactDelegate = self
        
        crashedInitializer()
        wallInitializer()
        dartsInitializer()
        enemyInitializer()
        targetInitializer()
    }
    
    func wallInitializer() {
        self.wall = childNode(withName: "wall") as! SKSpriteNode
        
        wall?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: self.frame.height))
        
        wall?.physicsBody?.affectedByGravity = false
        wall?.physicsBody?.isDynamic = false
        wall?.physicsBody?.restitution = 0
        
        wall?.physicsBody?.categoryBitMask = ColliderType.wall.rawValue
        wall?.physicsBody?.contactTestBitMask = ColliderType.foot.rawValue
        wall?.physicsBody!.collisionBitMask = ColliderType.foot.rawValue
    }
    
    func crashedInitializer() {
        for _ in 0...population!.populationSize {
            crashed?.append(false)
        }
    }
    
    func targetInitializer() {
        let nodeHeight = Int(self.frame.height) - 550
        let nodeWidth = 100
        
        self.target = SKSpriteNode(imageNamed: "target")
        
        self.target!.scale(to: CGSize(width: nodeWidth, height: nodeHeight))
        
        self.target!.position.x = CGFloat(-(self.initialDartsPosition?.x)!)
        self.target!.position.y = 0
        
        self.target!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: nodeWidth, height: nodeHeight))
        self.target!.physicsBody?.affectedByGravity = false
        self.target!.physicsBody?.isDynamic = false
        self.target!.physicsBody?.restitution = 0
        
        self.target!.physicsBody!.categoryBitMask = ColliderType.target.rawValue
        self.target!.physicsBody!.contactTestBitMask = ColliderType.foot.rawValue
        self.target!.physicsBody!.collisionBitMask = ColliderType.foot.rawValue
        
        self.addChild(self.target!)
        
    }
    
    func enemyInitializer() {
        let nodeHeight = 100
        let nodeWidth = 200
        
        let enemy = childNode(withName: "enemy") as! SKSpriteNode
        enemy.name = "enemy1"
        
        enemy.scale(to: CGSize(width: nodeWidth, height: nodeHeight))
        
        enemy.position.x = -100
        enemy.position.y = 0
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: nodeWidth, height: nodeHeight))
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.restitution = 0
        
        enemy.physicsBody!.categoryBitMask = ColliderType.enemy.rawValue
        enemy.physicsBody!.contactTestBitMask = ColliderType.foot.rawValue
        enemy.physicsBody!.collisionBitMask = ColliderType.foot.rawValue
        
        enemyes?.append(enemy)
    }
    
    func dartsInitializer() {
        let nodeHeight = 40
        let nodeWidth = 90
        
        for i in 0...population!.populationSize {
            let foot = SKSpriteNode(imageNamed: "dart")
            foot.name = "dart\(i)"
            
            foot.scale(to: CGSize(width: nodeWidth, height: nodeHeight))
            
            foot.position.x = CGFloat((self.initialDartsPosition?.x)!)
            foot.position.y = CGFloat((self.initialDartsPosition?.y)!)
            
            foot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: nodeWidth, height: nodeHeight))
            
            foot.physicsBody?.affectedByGravity = false
            foot.physicsBody?.restitution = 0
            
            foot.physicsBody!.categoryBitMask = ColliderType.foot.rawValue
            foot.physicsBody!.contactTestBitMask = ColliderType.enemy.rawValue
            foot.physicsBody!.collisionBitMask = ColliderType.enemy.rawValue
            
            darts?.append(foot)
            self.addChild(foot)
        }
    }
    
    func applyPhysicsOnDarts() {
        for index in 0...population!.populationSize {
            let xForce = population?.population[index].dna.genes[presentFrame].x
            let yForce = population?.population[index].dna.genes[presentFrame].y
            if !(crashed![index]) {
                darts![index].physicsBody?.applyImpulse(CGVector(dx: xForce!, dy: yForce!))
                //                darts![index].position.y += CGFloat(yForce!)
                //                darts![index].position.x += 5
            }
        }
    }
    
    func updateAllDarts() {
        for index in 0...population!.populationSize {
            population?.population[index].update(position: GAVector2D(x: Double(darts![index].position.x), y: Double(darts![index].position.y)))
        }
    }
    
    func restartAllDarts() {
        for index in 0...population!.populationSize {
            self.darts![Int(index)].physicsBody?.isDynamic = true
            
            darts![index].position.x = CGFloat((self.initialDartsPosition?.x)!)
            darts![index].position.y = CGFloat((self.initialDartsPosition?.y)!)
            
            self.darts![Int(index)].zRotation = 0
            
            population?.population[index].update(position: GAVector2D(x: Double(darts![index].position.x), y: Double(darts![index].position.y)))
            population?.population[index].restart()
            crashed![index] = false
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        if bodyA.categoryBitMask > bodyB.categoryBitMask {
            let buff = bodyA
            bodyA = bodyB
            bodyB = buff
        }
        
        if bodyA.categoryBitMask == ColliderType.foot.rawValue &&
            bodyB.categoryBitMask == ColliderType.enemy.rawValue {
            let index = (bodyA.node?.name?.suffix(1))!
            self.population?.population[Int(index)!].crash()
            self.darts![Int(index)!].physicsBody?.isDynamic = false
            self.crashed![Int(index)!] = true
        }
        else if bodyA.categoryBitMask == ColliderType.foot.rawValue &&
            bodyB.categoryBitMask == ColliderType.target.rawValue {
            let index = (bodyA.node?.name?.suffix(1))!
            self.population?.population[Int(index)!].reachedGoal()
            self.darts![Int(index)!].physicsBody?.isDynamic = false
        }
        else if bodyA.categoryBitMask == ColliderType.foot.rawValue &&
            bodyB.categoryBitMask == ColliderType.wall.rawValue {
            let index = (bodyA.node?.name?.suffix(1))!
            self.population?.population[Int(index)!].reachedGoal()
            self.darts![Int(index)!].physicsBody?.isDynamic = false
            self.crashed![Int(index)!] = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateAllDarts()
        applyPhysicsOnDarts()
        self.presentFrame += 1
        //averengeFitness()
        if self.presentFrame > GADna.dnaSize {
            self.population?.evaluate()
            self.population?.naturalSelection()
            self.restartAllDarts()
            self.presentFrame = 0
        }
    }
}

