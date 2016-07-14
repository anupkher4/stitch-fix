# stitch-fix

A basic page-based iOS app which allows a user to make a return/keep decision on an item and displays an invoice view with price breakdown for selected items.

____________________________________________________________________________________________
Before running the app:
1. Please run 'pod install' on the terminal in the project directory to install dependencies
2. Open the project using 'StitchFix.xcworkspace' file
____________________________________________________________________________________________


High-level flow of the application:
-----------------------------------
1. Loading screen - Loads all items for the current fix via an API call
2. Pages - Each item in the fix has its own page
  a. Each item page shows the item image, brand, name and price.
  b. Each page has a return/keep control to mark the item.
3. Last page - Displays a 'Checkout' button to move on to invoice view
4. Invoice view - Has a list of items marked 'Keep'
  a. Displays subtotal, tax and total for the items in the list calculated via an API call

App behavior notes:
-------------------
1. Invoice view has a button 'To Items' which takes the user back to item pages
2. Clicking 'To Items' clears the current item selection

UIKit libraries used:
---------------------
1. UIPageViewController - for displaying each item as an individual page
2. UITableViewController - for displaying selected items in a list

Third-party libraries used:
---------------------------
1. Alamofire - for making networking calls to the API
2. SwiftyJSON - for parsing incoming JSON into strongly-typed Swift objects
