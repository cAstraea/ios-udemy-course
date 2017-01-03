//
//  ViewController.swift
//  JSON Demo
//
//  Created by Razvan Comsa on 12/28/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=Chicago&sensor=false")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            
            if error != nil {
                print("thers an error in the log")
            } else {
                
                dispatch_async(dispatch_get_main_queue()) {
                 
                    do {
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        
                        let result = jsonResult["results"]
                        
                        let address = result![0]["formatted_address"] as! String
             
                        
                        print(address)



                    }
                    catch {
                        print("eroare json")
                    }
                    
                    
                }
            }
            
        }
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

