//
//  ViewController.swift
//  Permanent Storage
//
//  Created by Razvan Comsa on 12/11/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSUserDefaults.standardUserDefaults().setObject("Caim", forKey: "name")
       let name = NSUserDefaults.standardUserDefaults().objectForKey("name")!
        
        print(name)
        
        var arr = [1,2,3]
        NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "array")
        let recalled = NSUserDefaults.standardUserDefaults().objectForKey("array")!
        
        print(recalled[2])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

