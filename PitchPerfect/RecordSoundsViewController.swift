//  RecordSoundsViewController.swift
//  PitchPerfect
//  Created by Julia Miller on 9/25/15.
//  Copyright (c) 2015 Julia Miller. All rights reserved.

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate { //inherits functions from UIViewController

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true;
        recordButton.enabled = true;
        recordingLabel.text = "Tap to record."
        
    }
    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false;
        recordButton.enabled = false;
        recordingLabel.text = "Recording in progress..."
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        let session = AVAudioSession.sharedInstance();
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self;                          //ALLOWS THE AUDIO TO PASS TO PLAYSOUNDVIEWCONTROLLER
        audioRecorder.meteringEnabled = true;
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    //FUNCTION BELOW IS CALLED JUST BEFORE SEGUEWAY IS CALLED
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController 
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
   //METHOD INVOKED WHEN THE AUDIO HAS FINISHED RECORDING
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            audioRecorder.stop()
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio) //INHERITS METHOD FROM UIVIEWCONTROLLER
        }
        else{print("Recording was not successful")
            recordButton.enabled = true;
            stopButton.hidden = true;
        }
    }
    @IBAction func StopBtn(sender: UIButton) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance();
        do {
            try audioSession.setActive(false)
        } catch _ {
        }
    }

}

