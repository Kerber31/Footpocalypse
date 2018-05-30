//
//  Target.swift
//  Footpocalypse
//
//  Created by Matheus Kerber Venturelli on 15/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation
import SpriteKit

class Target {
    init(scene: SKScene) {
        let nodeHeight = scene.frame.height
        let nodeWidth = CGFloat(100)

        let target = SKSpriteNode(imageNamed: "target")

        target.scale(to: CGSize(width: nodeWidth, height: nodeHeight))

        target.position.x = CGFloat(Double(scene.frame.width/2 - 40))
        target.position.y = 0

        target.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: nodeWidth, height: nodeHeight))
        target.physicsBody?.affectedByGravity = false
        target.physicsBody?.isDynamic = false
        target.physicsBody?.restitution = 0

        target.physicsBody!.categoryBitMask = ColliderType.target.rawValue
        target.physicsBody!.contactTestBitMask = ColliderType.foot.rawValue
        target.physicsBody!.collisionBitMask = ColliderType.foot.rawValue

        scene.addChild(target)
    }
}
