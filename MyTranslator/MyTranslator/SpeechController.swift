//
//  SpeechController.swift
//  MyTranslator
//
//  Created by 김균환 on 2018. 5. 28..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit

extension UITextView {
    
    /// Modifies the top content inset to center the text vertically.
    ///
    /// Use KVO on the UITextView contentSize and call this method inside observeValue(forKeyPath:of:change:context:)
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}

class SpeechController: UIViewController {
    
    @IBOutlet private weak var TextView: UITextView!
    
    var Text: String?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPickerView" {
            if let PickerViewController = segue.destination as? PickerViewController {
                PickerViewController.Text = Text!
            }
        }
        if segue.identifier == "UnwindToViewController" {
            if segue.identifier == "ToTextResultView" {
                if let ViewController = segue.destination as? ViewController {
                    if(Text == nil) {
                        ViewController.Text = "음성을 녹음해주세요!"
                    }
                    ViewController.Text = Text
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Opa.png")!)
        TextView.text = Text
        self.TextView.alpha = 0.0
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
