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
import CoreLocation
class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    @IBOutlet weak var Record: UIButton!
    @IBOutlet weak var Reset: UIButton!
    
    var Text : String?
    var IsRecordTurn = true
    
    var target: String?
    var ResultText : String?
    var coor : CLLocationCoordinate2D?
    var timestamp : Date?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToTextResultView" {
        if let SpeechController = segue.destination as? SpeechController {
            if(Text == nil) {
                Text = "음성을 녹음해주세요!"
            }
            SpeechController.Text = Text
            }
        }
        if segue.identifier == "ToTableView" {
             if let HistoryViewController = segue.destination as? HistoryViewController {
            HistoryViewController.coor = coor
            HistoryViewController.ResultText = ResultText
            HistoryViewController.target = target
            HistoryViewController.timestamp = timestamp
            }
        }
    }
    
    func authorizeSR() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
               case .authorized:
                    print("authorized")
                case .denied:
                    self.Record.setTitle("Speech recognition access denied by user", for: .disabled)
                    
                case .restricted:
                    self.Record.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.Record.setTitle("Speech recognition not authorized", for: .disabled)

                }
            }
        }
    }
    
    @IBAction func RecordAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false { // 녹음안하고 있을때
            if IsRecordTurn == true // 녹음할 차례 일때
            {
                audioRecorder?.record()
                Record.setImage(UIImage(named: "stop.png"), for: .normal)
            } else  // 플레이할 차례 일때
            {
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
        else{ // 녹음하고 있을 때
            audioRecorder?.stop()
            Record.setImage(UIImage(named: "play.png"), for: .normal)
            IsRecordTurn = false
            
            // 다 끝나고 해도 될듯
            let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
            let request = SFSpeechURLRecognitionRequest(
                url: (audioRecorder?.url)!)
            speechRecognizer.recognitionTask(with: request, resultHandler: {
                (result, error) in
                self.Text = result?.bestTranscription.formattedString
            })
        }
    }
    @IBAction func RecordReset(_ sender: Any) {
        IsRecordTurn = true
        Record.setImage(UIImage(named: "record.png"), for: .normal)
        audioPlayer?.stop()
        audioRecorder?.stop()
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if(IsRecordTurn == false) {
            Record.isEnabled = true
        }
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Opa.png")!)
        Record.setImage(UIImage(named: "record.png"), for: .normal)
        Reset.setImage(UIImage(named: "reset.png"), for: .normal)
        
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

