//
//  ViewController.swift
//  Storing Images
//
//  Created by Razvan Comsa on 12/28/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var vapor: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        
        let url = NSURL(string: "https://levels.io/wp-content/uploads/2015/10/tumblr_nv2cqhOJPL1ufh7yno1_1280.png")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            
            if error != nil {
                print("thers an error in the log")
            } else {
                
                dispatch_async(dispatch_get_main_queue()) {
                    let image = UIImage(data: data!)
                   // self.vapor.image = image
                    
                    var docsDirectory: String?
                    
                    var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    
                    
                    if paths.count > 0 {
                        
                        docsDirectory = paths[0] as? String
                        
                        var savePath = docsDirectory! + "/someImage.jpg"
                        
                        NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                        
                        self.vapor.image = UIImage(named: savePath)
                    }
                    
                }
            }
            
        }
        
        task.resume()
        
        */
        
        var docsDirectory: String?
        
        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        
        if paths.count > 0 {
            
            docsDirectory = paths[0] as? String
            
            var savePath = docsDirectory! + "/someImage.jpg"

            
            self.vapor.image = UIImage(named: savePath)
        }
        
        
        
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

