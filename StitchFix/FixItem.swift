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
    
    var item_id: Int
    var item_name: String
    var item_price: String
    var item_brand: String
    var item_image_url: String
    var item_keep: Bool = false
    
    init(json: JSON) {
        self.item_id = json["id"].intValue
        self.item_name = json["name"].stringValue
        self.item_price = json["price"].stringValue
        self.item_brand = json["brand"].stringValue
        self.item_image_url = json["image_url"].stringValue
    }
    
}
