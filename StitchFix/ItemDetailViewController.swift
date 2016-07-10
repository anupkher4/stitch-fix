//
//  ItemDetailViewController.swift
//  StitchFix
//
//  Created by Anup Kher on 7/5/16.
//  Copyright © 2016 StitchFix. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var checkoutButton: UIBarButtonItem!
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemPriceLabel: UILabel!
    @IBOutlet var itemBrandLabel: UILabel!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemDecisionControl: UISegmentedControl!
    
    var itemDecision: String = ""
    
    var currentFixItem: FixItem?
    var showCheckout: Bool = false
    
    var invoiceController = InvoiceViewController()
    
    var itemState: [Int : String] = [:]
    
    @IBAction func decisionChanged(sender: AnyObject) {
        if let decision = self.itemDecisionControl.titleForSegmentAtIndex(self.itemDecisionControl.selectedSegmentIndex) {
            self.itemDecision = decision.lowercaseString
            if let item = self.currentFixItem {
                setItemDecision(forItemId: item.item_id)
            }
        }
    }
    
    @IBAction func checkoutClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("itemsToCheckout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if showCheckout {
            self.checkoutButton.enabled = true
            print("enabled")
        } else {
            self.checkoutButton.enabled = false
            print("disabled")
        }
        
        if currentFixItem != nil {
            setFixItemDetails(fixItem: currentFixItem!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setFixItemDetails(fixItem item: FixItem) {
        
        if let url = NSURL(string: item.item_image_url) {
            if let data = NSData(contentsOfURL: url) {
                if let image = UIImage(data: data) {
                    self.itemImageView.image = image
                }
            }
        }
        
        let components = item.item_price.componentsSeparatedByString(".")
        self.itemPriceLabel.text = "$\(components[0])"
        
        self.itemBrandLabel.text = "\(item.item_brand)"
        
        self.itemNameLabel.text = "\(item.item_name)"
        
        setItemDecision(forItemId: item.item_id)
    }
    
    func setItemDecision(forItemId itemId: Int) {
        self.itemState[itemId] = self.itemDecision
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
