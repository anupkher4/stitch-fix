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
    
    var currentFixItem: FixItem?
    var showCheckout: Bool = false
    
    // Create a static property to hold items to keep
    static var itemsToKeep: [FixItem] = []
    
    @IBAction func decisionChanged(sender: AnyObject) {
        if let item = self.currentFixItem {
            setItemDecision(forItem: item)
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
        } else {
            self.checkoutButton.enabled = false
        }
        
        if currentFixItem != nil {
            self.itemDecisionControl.selectedSegmentIndex = Int(currentFixItem!.item_keep)
            setFixItemDetails(fixItem: currentFixItem!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if let item = self.currentFixItem {
            setItemDecision(forItem: item)
        }
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
        
        setItemDecision(forItem: item)
    }
    
    func setItemDecision(forItem item: FixItem) {
        
        switch self.itemDecisionControl.selectedSegmentIndex {
        case 0:
            item.item_keep = false
            
            if !ItemDetailViewController.itemsToKeep.isEmpty {
                if let itemIndex = ItemDetailViewController.itemsToKeep.indexOf(item) {
                    print("Item removed")
                    ItemDetailViewController.itemsToKeep.removeAtIndex(Int(itemIndex))
                }
            }
        case 1:
            item.item_keep = true
            
            if !ItemDetailViewController.itemsToKeep.contains(item) {
                ItemDetailViewController.itemsToKeep.append(item)
                print("Item added")
            }
        default:
            print("Invalid segment index")
        }
        
    }
    
    func flushItemsToKeep() {
        ItemDetailViewController.itemsToKeep.removeAll()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "itemsToCheckout" {
            if let invoiceController = segue.destinationViewController as? InvoiceViewController {
                invoiceController.itemsToKeep = ItemDetailViewController.itemsToKeep
            }
        }
    }

}
