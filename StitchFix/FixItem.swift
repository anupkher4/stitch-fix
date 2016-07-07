//
//  FixItem.swift
//  StitchFix
//
//  Created by Anup Kher on 7/5/16.
//  Copyright © 2016 StitchFix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FixItem: NSObject {
    
    var id: Int
    var name: String
    var price: String
    var brand: String
    var image_url: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.price = json["price"].stringValue
        self.brand = json["brand"].stringValue
        self.image_url = json["image_url"].stringValue
    }
    
}
