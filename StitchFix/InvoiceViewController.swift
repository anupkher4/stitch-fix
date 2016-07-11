//
//  InvoiceViewController.swift
//  StitchFix
//
//  Created by Anup Kher on 7/9/16.
//  Copyright © 2016 StitchFix. All rights reserved.
//

import UIKit

class InvoiceViewController: UIViewController {
    
    @IBOutlet var itemsToKeepTableView: UITableView!
    @IBOutlet var keepingItemsLabel: UILabel!
    @IBOutlet var totalTopLabel: UILabel!
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var itemsToKeep: [FixItem] = []
    
    // Api Manager instance
    let apiManager = ApiManager()
    
    @IBAction func goBackToItems(sender: AnyObject) {
        self.performSegueWithIdentifier("checkoutBackToItems", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.modalPresentationCapturesStatusBarAppearance = true
        // Do any additional setup after loading the view.
        itemsToKeepTableView.delegate = self
        itemsToKeepTableView.dataSource = self
        
        var itemIds: [Int] = []
        for item in itemsToKeep {
            let id = item.item_id
            itemIds.append(id)
        }
        
        apiManager.getTotalForItems(listOfItemIds: itemIds, completion: { returnedTotal, error in
            self.activityIndicator.startAnimating()
            
            if error != nil {
                print("\(error?.domain)")
            }
            
            guard let totalDict = returnedTotal else {
                print("Error retrieveing total")
                return
            }
            
            self.keepingItemsLabel.text = "Keeping \(self.itemsToKeep.count) items"
            
            if let totalString = totalDict["total"] {
                let total = String(format: "%.02f", totalString)
                self.totalTopLabel.text = "Total = $\(total)"
                self.totalLabel.text = "$\(total)"
            }
            if let taxString = totalDict["tax"] {
                let tax = String(format: "%.02f", taxString)
                self.taxLabel.text = "$\(tax)"
            }
            if let subtotalString = totalDict["subtotal"] {
                let subtotal = String(format: "%.02f", subtotalString)
                self.subtotalLabel.text = "$\(subtotal)"
            }
            
            self.activityIndicator.stopAnimating()
        })
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.itemsToKeepTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension InvoiceViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsToKeep.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InvoiceTableViewCell", forIndexPath: indexPath) as! InvoiceTableViewCell
        
        let item = self.itemsToKeep[indexPath.row]
        
        if let url = NSURL(string: item.item_image_url) {
            if let data = NSData(contentsOfURL: url) {
                if let image = UIImage(data: data) {
                    cell.itemImageView.image = image
                }
            }
        }
        cell.itemBrandLabel.text = item.item_brand
        cell.itemNameLabel.text = item.item_name
        
        let components = item.item_price.componentsSeparatedByString(".")
        cell.itemPriceLabel.text = "$\(components[0])"
        
        return cell
    }
    
}

extension InvoiceViewController: UITableViewDelegate {
    
}