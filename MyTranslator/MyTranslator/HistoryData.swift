//
//  HistoryData.swift
//  MyTranslator
//
//  Created by 김균환 on 2018. 6. 12..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit
import CoreLocation

class Data : NSObject {
    
    var text: String?
    var target: String?
    var timestamp: Date?
    var coordinate: CLLocationCoordinate2D?
    
    init(text: String?, target: String?, timestamp: Date?, coordinate: CLLocationCoordinate2D?) {
        self.text = text
        self.target = target
        self.timestamp = timestamp
        self.coordinate = coordinate
    }
}
