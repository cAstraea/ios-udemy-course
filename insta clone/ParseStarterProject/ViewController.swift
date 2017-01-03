/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var signbutton: UIButton!
    
    @IBOutlet var registeredText: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    
    var signupActive = true
  
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    //function to display alerts
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            
            //dismiss the alert
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        //present the alert
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

    @IBAction func signUp(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in form", message: "Please enter a username and password")
            
        } else {
            //sign them up
            
            //busy indicator
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            
            activityIndicator.center = self.view.center
            
            activityIndicator.hidesWhenStopped = true
            
            var errorMessage = "Please try again later"
            
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            //save to parse
            if signupActive == true {
                var user = PFUser()
                
                user.username = username.text
                
                user.password = password.text
                
                
                
                
                user.signUpInBackgroundWithBlock({ (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        //signup successful
                        
                       // self.displayAlert("Account created", message: "You can now login as \(user.username!)")
                        
                        self.performSegueWithIdentifier("login", sender: self)
                        
                        
                        
                    } else {
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            
                            errorMessage = errorString
                            
                        }
                        
                        self.displayAlert("Failed signup", message: errorMessage)
                        
                    }
                })
                
            } else {
                //do login
                
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    
                    if user != nil {
                        // logged in
                        
                        self.performSegueWithIdentifier("login", sender: self)

                        
                    } else {
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            
                            errorMessage = errorString
                            
                        }
                        
                        self.displayAlert("Failed login", message: errorMessage)
                        
                    }
                    
                })
            }
            

            
        }
        
    }

    @IBAction func logIn(sender: AnyObject) {
        
        if signupActive == true {
            
            signbutton.setTitle("Log In", forState: UIControlState.Normal)
            
            registeredText.text = "Not Registered?"
            
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            signupActive = false
            
        } else {
            signbutton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            registeredText.text = "Already Registered?"
            
            loginButton.setTitle("Log In", forState: UIControlState.Normal)
            
            signupActive = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.username.delegate = self;
          self.password.delegate = self;

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
    }
    
override func viewDidAppear(animated: Bool) {
        //if user is logged in when starting the app jump to the user list
    let user = PFUser.currentUser()
    
    if user?.username == nil
    {
        // present loginViewController
        print("user is \(user?.username)")  // <--- who is currently
        
        //seague to login
        
        
    }
    else
    {
         print("user is \(user?.username)")  // <--- who is currently
        
        // show any viewcontroller
        self.performSegueWithIdentifier("login", sender: self)
    }
    
    
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
 //return dismiss keyb
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
