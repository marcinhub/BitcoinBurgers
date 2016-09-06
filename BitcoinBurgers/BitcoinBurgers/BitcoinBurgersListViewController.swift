//
//  ViewController.swift
//  BitcoinBurgers
//
//  Created by Marcin on 05/09/2016.
//  Copyright © 2016 MarcinSteciuk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class BitcoinBurgersListViewController: UIViewController {

    var bitcoinBurgersService: BitcoinBurgersService?
    var burgers: [Burger]?
    
   @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "Trending Movies";
        
        BitcoinBurgersService().getBitcoinBurgers() { (movies, error) in
            
            if error == nil {
                
                if let burgers = self.burgers {
                    
                    self.burgers = burgers
                    
                    print(self.burgers)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        self.tableVIew.reloadData()
                    }
                }
            }
            else {
                
                let alert = UIAlertController(title: "Alert", message: "No internet connection. Please connect to the internet.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}

