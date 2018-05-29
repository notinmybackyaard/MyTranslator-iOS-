//
//  PapagoDTO.swift
//  MyTranslator
//
//  Created by 김균환 on 2018. 5. 29..
//  Copyright © 2018년 김균환. All rights reserved.
//

import UIKit
import ObjectMapper

class PapagoDTO: Mappable {
    var message : Message?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
    }
    class Message: Mappable {
        var result : Result?
        
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            result <- map["result"]
        }
        class Result: Mappable {
            var translatedText : String?
            
            required init?(map: Map) {
                
            }
            
            func mapping(map: Map) {
                translatedText <- map["translatedText"]
            }
            

        }
        
    }

}
