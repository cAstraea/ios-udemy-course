//
//  ViewController.swift
//  Weather
//
//  Created by Razvan Comsa on 12/25/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userCity: UITextField!
    

    
    @IBAction func findWeather(sender: AnyObject) {
    var UC = userCity.text!
        
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + UC.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        if url != nil {
        
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false
                
                var weather = ""
                
                
                if error == nil {
                    let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                    // print(urlContent!)
                    
                    var urContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urContentArray.count > 1 {
                        
                        var weatherArray = urContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] as String
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        
                        
                    } else {
                        urlError = true
                    }
                    
                    
                    
                } else {
                    
                    urlError = true
                    
                }
                dispatch_async(dispatch_get_main_queue()) {
                    
                    print(weather)
                    
                    if urlError == true {
                        
                        self.showerror()
                        
                    } else {
                        self.resultLabel.text = weather
                        
                    }
                }
                
                
            })
            
            task.resume()
            
        } else {
            showerror()
        }
    }
    
    func showerror() {
        
         resultLabel.text = "was not able to find weather for " + userCity.text!
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

