//
//  RecordSoundVC
//  PitchPerfect
//
//  Created by Dandre Ealy on 12/6/16.
//  Copyright © 2016 Dandre Ealy. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundVC: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var startRecordingButton: UIButton!
    
    
    var audioRecorder: AVAudioRecorder!
    
    // Resize button image
    func sizeButtonImage(_ button: UIButton) {
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configUI(recording: false)
        sizeButtonImage(stopRecordingButton)
        sizeButtonImage(startRecordingButton)
        
    }
    
    // creating file & preparing audio
    
    func createAudio() {
        let folderPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingFileName = "recordedVoice.wav"
        let pathArray = [folderPath, recordingFileName]
        
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    //Start recording button
    @IBAction func startRecording(_ sender: Any) {
        configUI(recording: true)
        createAudio()
    }
    
    // Gets buttons and labels ready for display
    func configUI(recording:Bool) {
        recordingLabel.text = recording ? "Recording in progress" : "Tap to Record"
        
        startRecordingButton.isEnabled = !recording
        stopRecordingButton.isEnabled = recording
    }
    
    //Stop recording button
    @IBAction func stopRecording(_ sender: Any) {
        audioRecorder.stop()
        configUI(recording: false)
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "playSound", sender: audioRecorder.url)
        } else {
            print("error with file")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playSound" {
            let playVC = segue.destination as! PlaySoundVC
            let recordedAuioURL = sender as! URL
            playVC.recordedAudioURL = recordedAuioURL as URL!
        }
    }
}

