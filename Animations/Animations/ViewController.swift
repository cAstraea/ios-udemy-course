//
//  ViewController.swift
//  Animations
//
//  Created by Razvan Comsa on 12/26/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var counter = 1
    
    var timer = NSTimer()
    
    var isAnimating = true
    
    @IBOutlet var wolfImage: UIImageView!
    
    @IBAction func updateImage(sender: AnyObject) {
        if isAnimating == true {
            timer.invalidate()
            isAnimating = false
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.doAnimation), userInfo: nil, repeats: true)
            isAnimating = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.doAnimation), userInfo: nil, repeats: true)
    }
    
    func doAnimation() {
        if counter == 3 {
            counter = 1
        } else {
            counter += 1
        }
        
        wolfImage.image = UIImage(named: "005-\(counter) (dragged).tiff")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
    
       // wolfImage.center = CGPointMake(wolfImage.center.x - 400, wolfImage.center.y)
       // wolfImage.alpha = 0
       // wolfImage.frame = CGRectMake(100, 100, 0, 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1) { 
         //   self.wolfImage.center = CGPointMake(self.wolfImage.center.x + 400, self.wolfImage.center.y)
         //   self.wolfImage.alpha = 1
            
           // self.wolfImage.frame = CGRectMake(100, 100, 100, 200)

        }
    }


}

