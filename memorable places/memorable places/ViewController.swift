//
//  ViewController.swift
//  memorable places
//
//  Created by Razvan Comsa on 12/27/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!
    
    @IBOutlet var map: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1 {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        } else { // center map on user saved place and add annotation
            
            if !(places[activePlace]["lat"]!).isEmpty && !(places[activePlace]["lon"]!).isEmpty {
                let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
                
                let longitude = NSString(string: places[activePlace]["lon"]!).doubleValue
                
                var latDelta: CLLocationDegrees = 0.01
                var lonDelta: CLLocationDegrees = 0.01
                
                var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                
                var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                
                var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
                
                self.map.setRegion(region, animated: true)
                
                var annotation = MKPointAnnotation()
                
                annotation.coordinate = coordinate
                
                annotation.title = places[activePlace]["name"]
                
                self.map.addAnnotation(annotation)
            }
            

            
        }
        
       

        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        uilpgr.minimumPressDuration = 1
        
        map.addGestureRecognizer(uilpgr)
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            var touchPoint = gestureRecognizer.locationInView(self.map)
            
            var newCoordinate = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                
                var title = ""
                
                if (error == nil) {
                   if let p = placemarks?.first {
                    
                    var sub:String = ""
                    var tho:String = ""
                    
                    if p.subThoroughfare != nil {
                        sub = p.subThoroughfare!
                    }
                    
                    if p.thoroughfare != nil {
                        tho = p.thoroughfare!
                    }
                    
                     title = "\(sub) \(tho)"
                        
                    }
                    
                }
                
                if title == "" {
                    
                    title = "Added \(NSDate())"
                }
                
                places.append(["name":title, "lat":"\(newCoordinate.latitude)", "lon": "\(newCoordinate.longitude)"])
                
                // update defaults
                
                NSUserDefaults.standardUserDefaults().setObject(places, forKey: "placesList")
                
                var annotation = MKPointAnnotation()
                
                annotation.coordinate = newCoordinate
                
                annotation.title = title
                
                self.map.addAnnotation(annotation)
            })
            

        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var userLocation:CLLocation = locations[0]
        
        var latitude = userLocation.coordinate.latitude
        
        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.01
        
        var lonDelta: CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        self.map.setRegion(region, animated: true)
        
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

