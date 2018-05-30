//
//  Feet.swift
//  Footpocalypse
//
//  Created by Matheus Kerber Venturelli on 15/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation
import SpriteKit

class Feet {
    private var initialFeetPosition: GAVector2D?
    private let nodeHeight = 40
    private let nodeWidth = 90
    private let popSize: Int?
    private let scene: GameScene?
    var feet: [SKSpriteNode] = []
    
    init(scene: SKScene, populationSize: Int) {
        self.initialFeetPosition = GAVector2D(x: -Double(scene.frame.width/2 - 60), y: 0)
        self.popSize = populationSize
        self.scene = scene as? GameScene
        
        for i in 0...populationSize {
            let foot = SKSpriteNode(imageNamed: "foot1")
            foot.name = "foot\(i)"
            
            foot.scale(to: CGSize(width: nodeWidth, height: nodeHeight))
            
            foot.position.x = CGFloat((self.initialFeetPosition?.x)!)
            foot.position.y = CGFloat((self.initialFeetPosition?.y)!)
            
            foot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: nodeWidth, height: nodeHeight))
            
            foot.physicsBody?.affectedByGravity = false
            foot.physicsBody?.restitution = 0
            foot.physicsBody?.usesPreciseCollisionDetection = true
            foot.physicsBody?.linearDamping = 1
            
            foot.physicsBody!.categoryBitMask = ColliderType.foot.rawValue
            foot.physicsBody!.contactTestBitMask = ColliderType.table.rawValue | ColliderType.wall.rawValue | ColliderType.target.rawValue
            foot.physicsBody!.collisionBitMask = ColliderType.table.rawValue | ColliderType.wall.rawValue | ColliderType.target.rawValue
            
            self.feet.append(foot)
            scene.addChild(foot)
        }
        runAnnimation()
    }
    
    func update() {
        for index in 0...popSize! {
            scene?.population?.population[index].update(position: GAVector2D(x: Double((self.feet[index].position.x)), y: Double((self.feet[index].position.y))))
        }
    }
    
    func restart() {
        for index in 0...popSize! {
            self.feet[Int(index)].physicsBody?.isDynamic = true
            
            self.feet[index].position.x = CGFloat((self.initialFeetPosition?.x)!)
            self.feet[index].position.y = CGFloat((self.initialFeetPosition?.y)!)
            
            self.feet[Int(index)].zRotation = 0
            
            scene?.population?.population[index].update(position: GAVector2D(x: Double((self.feet[index].position.x)), y: Double((self.feet[index].position.y))))
            scene?.population?.population[index].restart()
//            scene?.crashed![index] = false
        }
        runAnnimation()
    }
    
    func runAnnimation() {
        var animationFrames: [SKTexture] = []
        
        
        for i in 1...8 {
            if i < 6 {
                animationFrames.append(SKTexture(imageNamed: "foot\(i)"))
            }
            else {
                animationFrames.append(SKTexture(imageNamed: "foot\(10 - i)"))
            }
        }
        
        for foot in feet {
            foot.removeAllActions()
            
            let fadeIn = SKAction.fadeIn(withDuration: 0.5)
            foot.run(fadeIn)
            foot.run(.animate(with: animationFrames, timePerFrame: 0.1))
        }
    }
    
    func applyPhysics() {
        for index in 0...popSize! {
            let xForce = scene?.population?.population[index].dna.genes[(scene?.presentFrame)!].x
            let yForce = scene?.population?.population[index].dna.genes[(scene?.presentFrame)!].y
            if !(scene?.population?.population[index].crashed)! {
                self.feet[index].physicsBody?.applyImpulse(CGVector(dx: xForce!, dy: yForce!))
            }
        }
    }
    
    func crashed(index: Int) {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        feet[index].texture = SKTexture(imageNamed: "brokenFoot")
        feet[index].run(fadeOut)
        BoneBreak.instance.playBreakingSound()
    }
}
