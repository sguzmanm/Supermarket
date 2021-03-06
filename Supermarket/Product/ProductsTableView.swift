//
//  ProductsTableViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit
import Network

class ProductsTableView: UIViewController {
    
    public var manager: CoreDataManager!
    var cartmanager = CartCoreDataManager()
    
    let networkMonitor = NWPathMonitor()
    var element = false;
    @IBOutlet weak var data: UIButton!
    
    @IBOutlet weak var resumeCart: UIBarButtonItem!
    
    @IBAction func addCart(_ sender: UIButton) {
        element = true;
        data.setTitle("Almacenado", for: UIControl.State())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       updateUI()
        do{
            if(element==false){ DispatchQueue.main.async {
                self.networkMonitor.pathUpdateHandler = { path in
                   
                      if path.status == .satisfied {
                          print("Estás conectado a la red")
                      
                      } else {
                          print("No estás conectado a la red")
                      
                        
                                     let VC = self.storyboard!.instantiateViewController(withIdentifier: "NotConnectionId") as! NotConection
                       VC.modalPresentationStyle = .fullScreen
                            
                        VC.manager = self.manager
                        
                        self.present(VC, animated: true, completion: nil)
                                               
                                               self.show(VC, sender: self)
                                  }
                        
                   }
                  }

                  let queue = DispatchQueue(label: "Network connectivity")
                  networkMonitor.start(queue: queue)
                
            }
        } catch  {
           print("Error — \(error)")
        }
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
            vc?.delegate = self
            
            
        }
        if segue.destination is ProductsCartTableViewController
        {
            let vc = segue.destination as? ProductsCartTableViewController
            vc?.manager = manager
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
