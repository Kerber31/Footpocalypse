//
//  BoneBreak.swift
//  Footpocalypse
//
//  Created by Matheus Kerber Venturelli on 20/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation
import AVFoundation

class BoneBreak {
    static let instance = BoneBreak()
    private init() {}
    private var audioPlayer = AVAudioPlayer()
    
    
    func playBreakingSound() {
        let tapSound = Bundle.main.path(forResource: "bone-breaking", ofType: "mp3")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: tapSound!))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error{
            print(error)
        }
        self.audioPlayer.play()
    }
}
