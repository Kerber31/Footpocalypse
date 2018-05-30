//
//  Enemy.swift
//  Footpocalypse
//
//  Created by Matheus Kerber Venturelli on 15/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation
import SpriteKit

class Table {
    let numberOfTables: Int = 3
    var tables: [SKSpriteNode] = []
    private var scene: SKScene?
    var tableFeet: [SKSpriteNode] = []
    
    init(scene: SKScene, tableType: String) {
        self.scene = scene
        let nodeHeight = 100
        let nodeWidth = 200
        
        for i in 0...(numberOfTables - 1) {
            let table = SKSpriteNode(imageNamed: tableType)
            table.name = "table\(i)"
        
            table.scale(to: CGSize(width: nodeWidth, height: nodeHeight))
        
            if i == 0 {
                table.position.x = -200
                table.position.y = 30
            }
            else if i == 1 {
                table.position.x = 332.0
                table.position.y = -200
            }
            else if i == 2 {
                table.position.x = 290.0
                table.position.y = 178.000015258789
            }
        
            table.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: nodeWidth, height: nodeHeight))
            table.physicsBody?.affectedByGravity = false
            table.physicsBody?.isDynamic = false
            table.physicsBody?.restitution = 0
        
            table.physicsBody!.categoryBitMask = ColliderType.table.rawValue
            table.physicsBody!.contactTestBitMask = ColliderType.foot.rawValue
            table.physicsBody!.collisionBitMask = ColliderType.foot.rawValue
        
            tables.append(table)
            scene.addChild(table)
        }
    }
    
    private func addTableFoot() {
        let nodeHeight = 100
        let nodeWidth = 20
        if tableFeet.count > 0 {
            tableFeet = []
        }
        for i in 0...(numberOfTables - 1) {
            let tableFoot = SKSpriteNode(imageNamed: "tableFoot")
            tableFoot.name = "tableFoot\(i)"
            
            tableFoot.scale(to: CGSize(width: nodeWidth, height: nodeHeight))
            
            if i == 0 {
                tableFoot.position.x = -285
                tableFoot.position.y = 30
            }
            else if i == 1 {
                tableFoot.position.x = 332.0 - 85
                tableFoot.position.y = -200
            }
            else if i == 2 {
                tableFoot.position.x = 290.0 - 85
                tableFoot.position.y = 178.000015258789
            }
            
            tableFoot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: nodeWidth, height: nodeHeight))
            tableFoot.physicsBody?.affectedByGravity = false
            tableFoot.physicsBody?.isDynamic = false
            tableFoot.physicsBody?.restitution = 0
            
            tableFoot.physicsBody!.categoryBitMask = ColliderType.table.rawValue
            tableFoot.physicsBody!.contactTestBitMask = ColliderType.foot.rawValue
            tableFoot.physicsBody!.collisionBitMask = ColliderType.foot.rawValue
            
            tableFeet.append(tableFoot)
            self.scene?.addChild(tableFoot)
            
            tableFoot.zPosition = tables[i].zPosition - 1
        }
    }
    
    func moveTableFeet(presentFrame: Int) {
        for index in 0...(numberOfTables - 1) {
            if presentFrame < GADna.dnaSize/4 {
                self.tableFeet[index].position.y += 1
            }
            else if presentFrame > 3*GADna.dnaSize/4 {
                self.tableFeet[index].position.y -= 1
            }
        }
    }
    
    func moveTables(presentFrame: Int) {
        for index in 0...(numberOfTables - 1) {
            if presentFrame < GADna.dnaSize/4 {
                self.tables[index].position.y -= 1
            }
            else if presentFrame < 3*GADna.dnaSize/4 {
                self.tables[index].position.y += 1
            }
            else if presentFrame > 3*GADna.dnaSize/4 {
                self.tables[index].position.y -= 1
            }
        }
    }
    
    private func changeToMovingTable() {
        if tableFeet.count > 0 {
            for i in 0...(tableFeet.count - 1) {
                tableFeet[i].removeFromParent()
            }
        }
        
        for i in 0...(numberOfTables - 1) {
            tables[i].removeAllActions()
            tables[i].texture = SKTexture(imageNamed: "movingTable")
            
            let textures = [SKTexture(imageNamed: "movingTable1"), SKTexture(imageNamed: "movingTable2")]
            
            let animation = SKAction.animate(with: textures, timePerFrame: 0.7)
            
            tables[i].run(.repeatForever(animation))
            
        }
    }
    
    private func changeToLittleToeDistroyer() {
        addTableFoot()
        
        for i in 0...(numberOfTables - 1) {
            tables[i].removeAllActions()
            tables[i].texture = SKTexture(imageNamed: "littleToeDistroyer")
        }
    }
    
    private func changeToRegularTable() {
        if tableFeet.count > 0 {
            for i in 0...(tableFeet.count - 1) {
                tableFeet[i].removeFromParent()
            }
        }
        
        for i in 0...(numberOfTables - 1) {
            tables[i].removeAllActions()
            tables[i].texture = SKTexture(imageNamed: "regularTable")
        }
    }
    
    func changeTableType(tableName: String) {
        switch tableName {
            case "movingTable":
                self.changeToMovingTable()
            case "littleToeDistroyer":
                self.changeToLittleToeDistroyer()
            case "regularTable":
                self.changeToRegularTable()
            default:
                return
        }
    }
}
