//
//  SpeechController.swift
//  MyTranslator
//
//  Created by 김균환 on 2018. 5. 28..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit

class SpeechController: UIViewController {

    @IBOutlet weak var TextView: UITextView!
    
    var Text: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPickerView" {
            if let PickerViewController = segue.destination as? PickerViewController {
                PickerViewController.Text = Text!
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TextView.text = Text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
