//
//  ViewController.swift
//  MyTranslator
//
//  Created by 김균환 on 2018. 5. 27..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit
import AVFoundation
import Speech
class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    @IBOutlet weak var Record: UIButton!
    @IBOutlet weak var Play: UIButton!
    @IBOutlet weak var Stop: UIButton!
    @IBOutlet weak var RecordDone: UIBarButtonItem!
    
    var Text : String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToTextResultView" {
        if let SpeechController = segue.destination as? SpeechController {
            SpeechController.Text = Text!
            }
        }
    }
    
    func authorizeSR() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.RecordDone.isEnabled = true
                
                case .denied:
                    self.RecordDone.isEnabled = false
                    self.Record.setTitle("Speech recognition access denied by user", for: .disabled)
                    
                case .restricted:
                    self.RecordDone.isEnabled = false
                    self.Record.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.RecordDone.isEnabled = false
                    self.Record.setTitle("Speech recognition not authorized", for: .disabled)
                }
            }
        }
    }
    
    @IBAction func RecordAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            Play.isEnabled = false
            Stop.isEnabled = true
            audioRecorder?.record()
        }
    }
    @IBAction func PlayAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            Stop.isEnabled = true
            Record.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func StopAudio(_ sender: Any) {
        Stop.isEnabled = false
        Play.isEnabled = true
        Record.isEnabled = true
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
        
        let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
        let request = SFSpeechURLRecognitionRequest(
            url: (audioRecorder?.url)!)
        speechRecognizer.recognitionTask(with: request, resultHandler: {
            (result, error) in
            self.Text = result?.bestTranscription.formattedString
        })
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Record.isEnabled = true
        Stop.isEnabled = false
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Play.isEnabled = false
        Stop.isEnabled = false
        
        let fileMgr = FileManager.default
        let dirPaths = fileMgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
        AVSampleRateKey: 44100.0] as [String : Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        authorizeSR()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

