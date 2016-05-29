//  PlaySoundViewController.swift
//  PitchPerfect
//  Created by Julia Miller on 10/11/15.
//  Copyright (c) 2015 Julia Miller. All rights reserved.

import UIKit
import AVFoundation //Need in order to play audio file

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
    audioPlayer.enableRate = true
    audioEngine = AVAudioEngine()
    audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl) //CONVERT NSURL TO AVAUDIOFILE FOR .SCHEDULEFILE
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()}
    
    @IBAction func playSnail(sender: UIButton) {
        stopAudio()
        changeRate(0.5)
    }
    @IBAction func playRabbit(sender: UIButton) {
        stopAudio()
        changeRate(2.0)
    }
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    @IBAction func playVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func stopSound(sender: UIButton) {
        stopAudio()
    }
    func playAudioWithVariablePitch(pitch:Float){
        stopAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    
    }
    func changeRate(rate:Float){
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    func stopAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
