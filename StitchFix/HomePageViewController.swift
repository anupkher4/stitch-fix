//
//  HomePageViewController.swift
//  StitchFix
//
//  Created by Anup Kher on 7/5/16.
//  Copyright © 2016 StitchFix. All rights reserved.
//

import UIKit

class HomePageViewController: UIPageViewController {
    
    // Api manager instance
    let apiManager = ApiManager()
    
    // Data model
    var fixItems: [FixItem] = []
    
    // For highlighting page index
    var currentItemIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.brownColor()
        
        // Get items in current fix
        apiManager.getCurrentFix({ items, error in
            if error != nil {
                print("Error: \(error?.domain)")
            }
            guard let allItems = items else {
                print("No items")
                return
            }
            
            self.fixItems = allItems
            
            // Set the first page for page view controller
            guard let initialViewController = self.viewControllerAtIndex(0, storyboard: self.storyboard!) else {
                print("Could not set initial view controller")
                return
            }
            let startingViewController: ItemDetailViewController = initialViewController
            let viewControllers = [startingViewController]
            self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: { done in })
        })
        
        
        // Set the initial view controller
        guard let currentStoryboard = self.storyboard else {
            print("Could not get current storyboard")
            return
        }
        guard let loadingScreen = currentStoryboard.instantiateViewControllerWithIdentifier("ItemModelViewController") as? ItemModelViewController else {
            print("Could not set loading screen")
            return
        }
        
        let startingViewController: ItemModelViewController = loadingScreen
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: { done in })
        
        // Set the data source
        self.dataSource = self
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

extension HomePageViewController: UIPageViewControllerDataSource {
    
    // Page View Helper functions
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> ItemDetailViewController? {
        // Return the item detail view controller for the given index
        if (self.fixItems.count == 0) || (index >= self.fixItems.count) {
            return nil
        }
        
        // Create new view controller and pass relevant data
        guard let itemDetailViewController = storyboard.instantiateViewControllerWithIdentifier("ItemDetailViewController") as? ItemDetailViewController else {
            print("Could not instantiate ItemDetailViewController at index \(index)")
            return nil
        }
        itemDetailViewController.currentFixItem = self.fixItems[index]
        self.currentItemIndex = index
        
        if index == (self.fixItems.count - 1) {
            itemDetailViewController.showCheckout = true
        } else {
            itemDetailViewController.showCheckout = false
        }
        
        return itemDetailViewController
    }
    
    func indexOfViewController(viewController: ItemDetailViewController) -> Int {
        // Return the index of the given data view controller
        guard let fixItem = viewController.currentFixItem else {
            return NSNotFound
        }
        guard let itemIndex = self.fixItems.indexOf(fixItem) else {
            return NSNotFound
        }
        return itemIndex
    }
    
    // In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
    // Return 'nil' to indicate that no more progress can be made in the given direction.
    // For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ItemDetailViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ItemDetailViewController)
        if index == NSNotFound {
            return nil
        }
        
        
        index += 1
        if index == self.fixItems.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    // The number of items reflected in the page indicator.
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.fixItems.count
    }
    
    // The selected item reflected in the page indicator.
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.currentItemIndex
    }
    
}

extension HomePageViewController: UIPageViewControllerDelegate {
    
    // Sent when a gesture-initiated transition begins.
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
    }
    
    // Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
}
