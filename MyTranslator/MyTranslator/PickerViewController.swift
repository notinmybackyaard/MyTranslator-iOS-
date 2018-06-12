//
//  PickerViewController.swift
//  MyTranslator
//
//  Created by 김균환 on 2018. 5. 29..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    var target : String = "en"
    var Text : String?
    
    var pickerDataSource = ["영어", "중국어 간체", "중국어 번체", "스페인어", "프랑스어", "베트남어", "태국어",
                            "인도네시아어"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            target = "en"
        } else if row == 1 {
            target = "zh-CN"
        } else if row == 2 {
            target = "zh-TW"
        } else if row == 3 {
            target = "es"
        } else if row == 4 {
            target = "fr"
        } else if row == 5 {
            target = "vi"
        } else if row == 6 {
            target = "th"
        } else if row == 7 {
            target = "id"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToTranslatedResultView" {
            if let TranslatedResultViewController = segue.destination as? TranslatedResultViewController {
                TranslatedResultViewController.Text = Text!
                TranslatedResultViewController.target = target
            }
        }  else if segue.identifier == "UnwindToTextResultView" {
            if let SpeechController = segue.destination as? SpeechController {
                SpeechController.Text = Text!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Opa.png")!)
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
