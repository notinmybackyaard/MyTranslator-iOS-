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

class TranslatedResultViewController: UIViewController {

    var target: String?
    var Text : String?
    @IBOutlet weak var TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    var url = "https://openapi.naver.com/v1/papago/n2mt"
    var params = ["source":"ko",
                  "target":target!,
                  "text":Text!] as [String : Any]
        var header = ["Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
                      "X-Naver-Client-Id":"HiX3Q40iVxLCUqchGfBg",
                      "X-Naver-Client-Secret":"yc1NSwkkgh"]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseObject { (response:DataResponse<PapagoDTO >) in
            var papagoDTO = response.result.value
            self.TextView.text = papagoDTO?.message?.result?.translatedText
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
