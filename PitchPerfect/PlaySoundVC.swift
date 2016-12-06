//
//  PlaySoundVC.swift
//  PitchPerfect
//
//  Created by Dandre Ealy on 12/6/16.
//  Copyright © 2016 Dandre Ealy. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundVC: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
     
}
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureUI(.notPlaying)
    }

    @IBAction func stopSoundButton(_ sender: Any) {
        
        stopAudio()
    }
   
    @IBAction func playSoundButton(_ sender: UIButton) {
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    
    }
}
