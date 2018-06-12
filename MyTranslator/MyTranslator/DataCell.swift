//
//  DataCell.swift
//  MyTranslator
//
//  Created by 김균환 on 2018. 6. 12..
//  Copyright © 2018년 김균환. All rights reserved.
//
import UIKit

class DataCell: UITableViewCell {
    
    @IBOutlet weak var TimeStampLabel: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var TargetLabel: UILabel!
    
    
    let date = DateFormatter()
    var kr : String?
    
    var HistoryData: Data! {
        didSet {
            kr = date.string(from: HistoryData.timestamp!)
            TimeStampLabel.text = kr
            TextLabel.text = HistoryData.text
            TargetLabel.text = HistoryData.target
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
