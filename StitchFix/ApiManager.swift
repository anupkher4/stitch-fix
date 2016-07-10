//
//  ApiManager.swift
//  StitchFix
//
//  Created by Anup Kher on 7/7/16.
//  Copyright © 2016 StitchFix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
    
    let endpoint = "https://fake-mobile-backend.herokuapp.com/api/current_fix"
    
    func getCurrentFix(completion: ([FixItem]?, NSError?) -> ()) {
        
        var itemList = [FixItem]()
        
        Alamofire.request(.GET, endpoint, encoding: .JSON).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .Success(let value):
                let json = JSON(value)
                for (_, item):(String, JSON) in json["shipment_items"] {
                    let fixItem = FixItem(json: item)
                    itemList.append(fixItem)
                }
                print("Fetched items from backend: \(itemList.count)")
                completion(itemList, nil)
                
            case .Failure(let error):
                print("\(error)")
                completion(nil, error)
            }
            
        })
        
    }
    
    func getTotalForItems(listOfItemIds itemIds: [Int], completion: ([String : Double]?, NSError?) -> ()) {
        
        var totalForItems = [String : Double]()
        
        let payload = [
            "keep": itemIds
        ]
        
        Alamofire.request(.PUT, endpoint, parameters: payload, encoding: .JSON).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .Success(let value):
                let json = JSON(value)
                
                totalForItems["total"] = json["total"].doubleValue
                totalForItems["subtotal"] = json["subtotal"].doubleValue
                totalForItems["tax"] = json["tax"].doubleValue
                
                completion(totalForItems, nil)
                
            case .Failure(let error):
                print("\(error)")
                completion(nil, error)
            }
            
        })
        
    }
    
}
