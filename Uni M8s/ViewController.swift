//
//  ViewController.swift
//  Uni M8s
//
//  Created by louis christodoulou on 03/05/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController
{
    

    @IBOutlet var Name: UITextField!
    
    @IBOutlet var UniversityEmail: UITextField!
    
    @IBOutlet var Password: UITextField!
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    func displayAlert(title: String, message: String) {
    
        if UniversityEmail.text == "" || Password.text == "" || Name.text == "" {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
  
        
        
    }
    }
    
    
        @IBAction func Signup(sender: AnyObject) {
            
            if UniversityEmail.text == "" || Password.text == "" || Name.text == "" {
            
            
            
            
            
            } else {
        
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            let user = PFUser()
            user.username = Name.text
            user.password = Password.text
            user.email = UniversityEmail.text
            
            var errorMessage = "oops please try again"
            
            
            user.signUpInBackgroundWithBlock({ (success, error) in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                 
                    // Signup was successful
                    
                } else {
                    
                    if let errorString = error!.userInfo["error"] as? String {
                        
                        errorMessage = errorString
                        
                
                   }
            
            
            }
                
                })
    
            
    
            
            
            
    
                }}
        
    
        
    
                

    
    @IBAction func Login(sender: AnyObject) {
    }

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
                    }}




