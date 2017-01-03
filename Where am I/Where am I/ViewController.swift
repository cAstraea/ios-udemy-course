//
//  ViewController.swift
//  Where am I
//
//  Created by Razvan Comsa on 12/27/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    
    

    @IBOutlet var latitudelabel: UILabel!
    
    @IBOutlet var longitudelabel: UILabel!
    
    @IBOutlet var courselabel: UILabel!
    
    @IBOutlet var speedlabel: UILabel!
    
    @IBOutlet var altitudelabel: UILabel!
    
    @IBOutlet var addresslabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = CLLocationManager()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userLocation:CLLocation = locations[0]
        
        self.latitudelabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudelabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courselabel.text = "\(userLocation.course)"
        
        self.speedlabel.text = "\(userLocation.speed)"
        
        self.altitudelabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if (error != nil) {
                print(error)
            } else {
                
                if let p = placemarks?.first where error == nil {
                    var subTho:String = ""
                    if(p.subThoroughfare != nil) {
                        subTho = p.subThoroughfare!
                    }
                    
                    self.addresslabel.text = "\(subTho) \(p.thoroughfare!)  \n \(p.subLocality) \n \(p.subAdministrativeArea!)  \n \(p.postalCode!) \n \(p.country!)"
                    
              
                    
                }
                
            }
        }
        
      
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

