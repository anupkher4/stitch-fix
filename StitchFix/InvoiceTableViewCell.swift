//
//  InvoiceTableViewCell.swift
//  StitchFix
//
//  Created by Anup Kher on 7/10/16.
//  Copyright © 2016 StitchFix. All rights reserved.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {

    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemBrandLabel: UILabel!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
