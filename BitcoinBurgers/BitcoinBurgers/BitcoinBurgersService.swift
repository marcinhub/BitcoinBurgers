//
//  BitcoinBurgersService.swift
//  BitcoinBurgers
//
//  Created by Marcin on 05/09/2016.
//  Copyright © 2016 MarcinSteciuk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift


class BitcoinBurgersService: UIViewController {

    
    func getBitcoinBurgers(completion:(([Burger]?, NSError?) -> ())) {
        
        let network = Network()
        
        network.download { (json, error) in
            
            if error == nil {
                
                if let json = json {
                    
                    let burgerParser = BitcoinBurgersParser(bitcoinBurgersArray: json)
                    let burgers = burgerParser.getBurgers()
                    print(burgers)
                    
                    completion(burgers, nil)
                }
            }
            else {
                completion(nil, error)
            }
        }
    }


    
    struct BitcoinBurgersParser {
   
        let bitcoinBurgersArray: [String: AnyObject]
        
        init(bitcoinBurgersArray: [String: AnyObject]) {
        
            self.bitcoinBurgersArray = bitcoinBurgersArray
        }
        
        func getBurgers() -> [Burger] {
        
            let json = JSON(bitcoinBurgersArray)
                    
                    
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
            print(products)
            return products

        }
}
}




