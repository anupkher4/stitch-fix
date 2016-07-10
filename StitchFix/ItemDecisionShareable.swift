//
//  ItemDecisionShareable.swift
//  StitchFix
//
//  Created by Anup Kher on 7/9/16.
//  Copyright © 2016 StitchFix. All rights reserved.
//

import Foundation

protocol ItemStateShareable {
    
    var itemsToKeep: [FixItem] { get set }
    
}
