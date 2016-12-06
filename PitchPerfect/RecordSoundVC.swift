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
    @IBOutlet weak var stopRecordingBtn: UIButton!
    @IBOutlet weak var startRecordingBtn: UIButton!
    
    var audioRecorder: AVAudioRecorder!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        recordingLabel.text = "Tap to Record"
        stopRecordingBtn.isEnabled = false
        startRecordingBtn.isEnabled = true
        
    }
    
    //Start recording button 
    @IBAction func startRecording(_ sender: Any) {
        stopRecordingBtn.isEnabled = true
        recordingLabel.text = "Recording"
        startRecordingBtn.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        
       try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    //Stop recording button
    @IBAction func stopRecording(_ sender: Any) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)

    }

    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
             performSegue(withIdentifier: "playSound", sender: audioRecorder.url)
        } else {
            print("Error sending file")
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

