//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Razvan Comsa on 12/28/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        //var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        
       // newUser.setValue("Tom", forKey: "username")
        
    //newUser.setValue("degetel", forKey: "password")
        
        do {
             try context.save()
        }
       
        catch {
            print("error")
        }
        
        
        var request = NSFetchRequest(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        request.predicate = NSPredicate(format: "username = %@", "Rob")
        do {
           var results = try context.executeFetchRequest(request)
           
            if results.count > 0 {
                
                print(results)
                for result: AnyObject in results {
               
                    if let user = result.valueForKey("username") as? String {
                        
                        if user == "Rob" {
                           // context.deleteObject(result as! NSManagedObject)
                            
                          //  print(user + " has been deleted ")
                            
                            result.setValue("pass123456", forKey: "password")
                        }
                        
                      
                    }
                    
                    do {
                        try context.save()
                    }
                        
                    catch {
                        print("error")
                    }
                    
                  
                    
                }
            } else {
                print("no results")
            }
           
        }
        catch {
            print("egg error")
        }
       
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

