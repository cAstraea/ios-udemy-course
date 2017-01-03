//
//  ViewController.swift
//  How Many Fingers
//
//  Created by Razvan Comsa on 10/6/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var guess: UITextField!
    
    @IBAction func guessButton(sender: AnyObject) {
        
     let randomNumber = arc4random_uniform(6)
        
        let guessInt = Int(guess.text!)
        
        if guessInt != nil {
            if Int(randomNumber) == guessInt {
                resultLabel.text = "Correct"

            } else {
                 resultLabel.text = "Nop it was \(randomNumber)"
            }
        } else {
            resultLabel.text = "Please enter a number 0 - 5"
        }
        
       
    }
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

