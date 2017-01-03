//
//  ViewController.swift
//  Cat Years
//
//  Created by Razvan Comsa on 8/28/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var catAge: UITextField!
    @IBAction func calculateAge(sender: AnyObject) {
        print(catAge.text)
        
        let enteredAge = Int(catAge.text!)
        if enteredAge != nil {
              let catYears = enteredAge! * 7
            realAge.text = "your cat is \(catYears) in cat years     "

        }
        else {
            realAge.text = "enter age"
        }
        
      
        
        
        
      
        
    }
    @IBOutlet var realAge: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

