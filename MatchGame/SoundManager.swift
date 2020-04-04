//
//  SoundManager.swift
//  MatchGame
//
//  Created by Caio on 04/04/20.
//  Copyright © 2020 Caio. All rights reserved.
//

import Foundation
import AVFoundation

public class SoundManager {
    static var audioPlayer: AVAudioPlayer?
    
    public enum SoundEffect
    {
        case flip
        case correct
        case wrong
        case shuffle
    }
    
    static func playSound(_ soundEffect: SoundEffect){
        var soundFile = ""
        switch soundEffect {
        case .flip:
            soundFile = "cardflip"
            break;
        case .correct:
            soundFile = "dingcorrect"
            break;
        case .wrong:
            soundFile = "dingwrong"
            break;
        case .shuffle:
            soundFile = "shuffle"
            break;
        }
        
        let audioFile = Bundle.main.path(forResource: soundFile, ofType: "wav")
        let fileUrl = URL(fileURLWithPath: audioFile!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: fileUrl)
            audioPlayer?.play()
        }catch
        {
            print("File \(soundFile) not found")
        }
    }
}
