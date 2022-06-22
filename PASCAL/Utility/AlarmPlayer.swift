//
//  AlarmPlayer.swift
//  PASCAL
//
//  Created by Keshav Infotech on 18/06/22.
//

import Foundation
import AVFoundation

class AlarmPlayer : NSObject {
    
    static let shared = AlarmPlayer()
    var player: AVAudioPlayer!
    var isPlaying = false
    
    override init() {
        super.init()
        let url = Bundle.main.url(forResource: "AnchhorEasy_FCM", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.numberOfLoops = -1
    }

    func playAlertSound() {
        if !isPlaying {
            isPlaying = true
            player.play()
        }
    }
    
    func stopAlertSound() {
        if isPlaying {
            isPlaying = false
            if let player = player {
                player.stop()
            }
        }
    }
}
