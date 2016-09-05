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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://coffeeport.herokuapp.com/burgers/?format=json")
            .responseJSON { (response) -> Void in
                
                if let value = response.result.value {
                    
                    let json = JSON(value)
/*
                    
                    var productsDictionary = [String]()
                    if let data = json["data"] as? [[String: AnyObject]] {
                        for dat in data {
                            if let prod = dat["data"] as? String {
                                productsDictionary.append(prod)
                                
                            }}}
                    
                    print(productsDictionary)
*/
                    var products = [Burger]()
                    for (key, _) in json["burgers"] {
                        let product=Burger()
                        product.id = json["burgers"][Int(key)!]["id"].intValue
                        product.price = json["burgers"][Int(key)!]["bitcoin"].intValue
                        product.image = json["burgers"][Int(key)!]["image"].stringValue
                        product.name = json["burgers"][Int(key)!]["name"].stringValue
                        product.promoted = json["burgers"][Int(key)!]["promoted"].boolValue
                        product.notes = json["burgers"][Int(key)!]["notes"].stringValue
                        product.vegetarian = json["burgers"][Int(key)!]["vegetarian"].boolValue

                        products.append(product)
                    }

                }
        }
        
    }
    
    
    
    
    //    let redableJSON = JSON(data: JSON(value), options: NSJSONReadingOptions.MutableContainers, error: nil)
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


