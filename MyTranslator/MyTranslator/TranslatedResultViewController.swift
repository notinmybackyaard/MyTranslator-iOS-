//
//  TranslatedResultViewController.swift
//  MyTranslator
//
//  Created by 김균환 on 2018. 5. 29..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import CoreLocation

class TranslatedResultViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager:CLLocationManager!
    
    @IBOutlet private weak var TextView: UITextView!
    @IBOutlet weak var HomeButton: UIButton!
    
    var target: String?
    var Text : String?
    var coor : CLLocationCoordinate2D?
    var timestamp : Date?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindToPickerView" {
            if let PickerViewController = segue.destination as? PickerViewController {
                PickerViewController.Text = Text!
                PickerViewController.target = self.target!
            }
        }
        if segue.identifier == "UnwindToHome" {
            if let ViewController = segue.destination as? ViewController {
                //현재위치 가져오기
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization() //권한 요청
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
                coor = locationManager.location?.coordinate
                timestamp = locationManager.location?.timestamp
                ViewController.coor = coor
                ViewController.ResultText = TextView.text
                ViewController.target = target
                ViewController.timestamp = timestamp
            }
        }
    }

    
    @IBAction func GoToHome(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Opa.png")!)
    let url = "https://openapi.naver.com/v1/papago/n2mt"
    let params = ["source":"ko",
                  "target":target!,
                  "text":Text!] as [String : Any]
        let header = ["Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
                      "X-Naver-Client-Id":"HiX3Q40iVxLCUqchGfBg",
                      "X-Naver-Client-Secret":"yc1NSwkkgh"]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseObject { (response:DataResponse<PapagoDTO >) in
            let papagoDTO = response.result.value
            self.TextView.text = papagoDTO?.message?.result?.translatedText
        }
        self.TextView.alpha = 0.0
        HomeButton.setImage(UIImage(named: "home.png"), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        TextView.alignTextVerticallyInContainer()
        UIView.animate(withDuration: 1.5, animations: {
            self.TextView.alpha = 1.0
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
