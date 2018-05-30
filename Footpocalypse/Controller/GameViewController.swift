//
//  GameViewController.swift
//  test
//
//  Created by Matheus Kerber Venturelli on 13/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func storeButtonTouchUpInside(_ sender: UIButton) {
        sender.setImage(UIImage(named: "storeButton"), for: .normal)
    }
    

    @IBAction func storeButtonTouchDown(_ sender: UIButton) {
        sender.setImage(UIImage(named: "storeButtonPressed"), for: .normal)
        ButtonClick.instance.playButtonSound()
    }
    
    @IBAction func storeButtonTouchDragExit(_ sender: UIButton) {
        sender.setImage(UIImage(named: "storeButton"), for: .normal)
    }
    
}










