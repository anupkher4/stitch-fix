//
//  ItemModelController.swift
//  StitchFix
//
//  Created by Anup Kher on 7/7/16.
//  Copyright © 2016 StitchFix. All rights reserved.
//

import UIKit

class ItemModelViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
    }
    
}
