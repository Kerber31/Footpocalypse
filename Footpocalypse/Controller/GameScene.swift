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
    
    private var money: SKLabelNode?
    private var feet : Feet?
    private var target: Target?
    private var tables: Table?
    private var initialFeetPosition: GAVector2D?
    private var targetPosition: GAVector2D?
    var population: GAPopulation?
    var presentFrame: Int = 0
    var currentTable: String = "regularTable"
    
    private var feetKilled = 0
    
    override func didMove(to view: SKView) {
        
        let screenSize = GAVector2D(x: Double(self.frame.width), y: Double(self.frame.height))
        self.initialFeetPosition = GAVector2D(x: -Double(self.frame.width/2 - 60), y: 0)
        self.targetPosition = GAVector2D(x: -Double(self.frame.width/2), y: 0)
        
        
        self.population = GAPopulation(screenSize: screenSize, position: self.initialFeetPosition!, targetPosition: self.targetPosition!)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        self.feet = Feet(scene: self, populationSize: (population?.populationSize)!)
        self.target = Target(scene: self)
        self.tables = Table(scene: self, tableType: Dao.instance.getTableType())
        
        money = childNode(withName: "money") as? SKLabelNode
        money?.text = String(Dao.instance.getmoney())
        
        wallInitializer()
        playMusic()
    }
    
    func playMusic(){
        let backgroundMusic = SKAudioNode(fileNamed: "HiddenPast.mp3")
        self.addChild(backgroundMusic)
    }
    
    func wallInitializer() {
        let wall = SKPhysicsBody(edgeLoopFrom: self.frame)
        wall.restitution = 0
        wall.isDynamic = false
        wall.affectedByGravity = false
        
        wall.categoryBitMask = ColliderType.wall.rawValue
        wall.contactTestBitMask = ColliderType.foot.rawValue
        wall.collisionBitMask = ColliderType.foot.rawValue
        
        self.physicsBody = wall
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
            bodyB.categoryBitMask == ColliderType.table.rawValue {
            let index = (bodyA.node?.name?.suffix(1))!
            self.population?.population[Int(index)!].crash()
            self.feet?.crashed(index: Int(index)!)
            self.feet?.feet[Int(index)!].physicsBody?.isDynamic = false
            self.physicsBody?.velocity = CGVector.zero
            
            Dao.instance.setmoney(money: Dao.instance.getmoney() + 1)
        }
        else if bodyA.categoryBitMask == ColliderType.foot.rawValue &&
            bodyB.categoryBitMask == ColliderType.target.rawValue {
            let index = (bodyA.node?.name?.suffix(1))!
            self.population?.population[Int(index)!].reachedGoal()
            self.feet?.feet[Int(index)!].physicsBody?.isDynamic = false
        }
        else if bodyA.categoryBitMask == ColliderType.foot.rawValue &&
            bodyB.categoryBitMask == ColliderType.wall.rawValue {
            let index = (bodyA.node?.name?.suffix(1))!
            self.population?.population[Int(index)!].crash()
            self.feet?.crashed(index: Int(index)!)
            self.feet?.feet[Int(index)!].physicsBody?.isDynamic = false
            self.physicsBody?.velocity = CGVector.zero
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        feet?.update()
        feet?.applyPhysics()
        money?.text = String(Dao.instance.getmoney())
        presentFrame += 1
        if presentFrame > GADna.dnaSize {
            if currentTable != Dao.instance.getTableType() {
                tables?.changeTableType(tableName: Dao.instance.getTableType())
                currentTable = Dao.instance.getTableType()
            }
            population?.evaluate()
            population?.naturalSelection()
            feet?.restart()
            presentFrame = 0
        }
        if currentTable == "littleToeDistroyer" {
            tables?.moveTableFeet(presentFrame: presentFrame)
        }
        else if currentTable == "movingTable" {
            tables?.moveTables(presentFrame: presentFrame)
        }
    }
}
