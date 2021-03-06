//
//  ProductsTableViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class ProductsCartTableView: UIViewController {
    
    public var manager: CoreDataManager!
    var cartmanager = CartCoreDataManager()
    
    
    
    @IBOutlet weak var resumeCart: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       updateUI()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.destination is ProductsTableViewController
        {
            let vc = segue.destination as? ProductsTableViewController
            vc?.manager = manager
            
            
        }
        if segue.destination is ProductsCartTableViewController
        {
            let vc = segue.destination as? ProductsCartTableViewController
            vc?.manager = manager
            vc?.delegate = self
        }
    }
  func updateUI() {
          //3
      let cart = cartmanager.fetchUserCart(container: manager.getContainer())
             
      var price : Double = 0
             
             for i in cart.products!
             {
              price = price + (i as! Product).price
                 
             }
          
      resumeCart.title = "$ \(price)"
  }

    

}
