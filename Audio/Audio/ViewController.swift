//
//  ViewController.swift
//  Audio
//
//  Created by Razvan Comsa on 12/28/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet var toolbar: UIToolbar!
    
    var isPaused:Bool = false
    
    @IBAction func PlayPause(sender: AnyObject) {
        print("called play action")
        
        var toggleButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "PlayPause:")
        
        if isPaused == false {
            print("resuming")
            player.play()
            
            //change button to pause
            toggleButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "PlayPause:")
        } else {
            print("pausing")
           player.pause()
        }
        
        var items = toolbar.items!
        items[0] = toggleButton
        
        toolbar.setItems(items, animated: true)
        
        isPaused = !isPaused
    }
    


    
    
    @IBAction func stop(sender: AnyObject) {
        print("stopping")
        player.stop()
        player.currentTime = 0
        isPaused = false
       var toggleButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "PlayPause:")
        
        var items = toolbar.items!
        items[0] = toggleButton
        
        toolbar.setItems(items, animated: true)
        
        
    }
    
    
    @IBAction func sliderChanged(sender: AnyObject) {
        player.volume = sliderValue.value
    }
    
    
    @IBOutlet var sliderValue: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let audioPath =  NSBundle.mainBundle().pathForResource("Tsukurimashou", ofType: "mp3")!
        
do {
            player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
        
            
        }
        catch let error as NSError {
            
            print("shit hit the fan: \(error.localizedDescription)")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

