//
//  ViewController.swift
//  Is it prime
//
//  Created by Razvan Comsa on 11/14/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var number: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let numberInt = Int(number.text!)
        
        if numberInt != nil
        {
            let unwrappedNumber = numberInt!
            var isPrime = true
            if unwrappedNumber == 1 {
                isPrime = false
            }
            
            if unwrappedNumber != 2 && unwrappedNumber != 1 {
                for var i = 2; i < unwrappedNumber; i+=1 {
                    if unwrappedNumber % i == 0 {
                        isPrime = false
                    }
                }
            }
            if isPrime == true {
                resultLabel.text = "\(unwrappedNumber) is prime"
            } else {
                   resultLabel.text = "\(unwrappedNumber) is not prime"
            }
        } else {
            resultLabel.text = " Please enter a number in the box"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

