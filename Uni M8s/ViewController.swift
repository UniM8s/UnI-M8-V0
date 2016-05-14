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
    var ActiveSignUp = true

    @IBOutlet var Name: UITextField!
    
    @IBOutlet var UniversityEmail: UITextField!
    
    @IBOutlet var Password: UITextField!
    
   
    //Button Actions
    
    
    @IBOutlet var SignUpLogin: UIButton! //duplicate
    
    @IBOutlet var SignupButton: UIButton!
  
    @IBOutlet var RegisteredText: UILabel!
    
    @IBOutlet var LoginSignButton: UIButton!
    
    
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
            
            displayAlert("Error In Form", message: "oops! Please enter your name, a valid university email, and password")
            
            
            
            } else {
        
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
                
            var errorMessage = "oops please try again"
                
            if ActiveSignUp == true {
                
                
            let user = PFUser()
            user.username = Name.text
            user.password = Password.text
            user.email = UniversityEmail.text
            
           
            
            
            user.signUpInBackgroundWithBlock({ (success, error) in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                 
                    // Signup was successful
                    
                    self.performSegueWithIdentifier("Login", sender: self)
                    
                    
                    
                } else {
                    
                    if let errorString = error!.userInfo["error"] as? String {
                        
                        errorMessage = errorString
                        
                
                   }
            
                self.displayAlert("Failed Signup", message: errorMessage)
                    
            
            }
                
                })
                    
                } else {
                
                PFUser.logInWithUsernameInBackground(UniversityEmail.text!, password: Password.text!, block:
                        { (user,error) -> Void in
                            
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                            
                            if user != nil {
                                //logged in
                                
                              
                                
                                self.performSegueWithIdentifier("login", sender: self)
                                
                                
                                
                            } else {

                                if let errorString = error!.userInfo["error"] as? String {
                                    
                                    errorMessage = errorString
                                    
                                    
                                }
                                
                                self.displayAlert("Failed Login", message:errorMessage)
                            }
                
    
            
    
                    })
        
        
                }}
        
                
            }
            

    
    @IBAction func Login(sender: AnyObject) {
       
       
        
        if ActiveSignUp == true {
            
         SignUpLogin.setTitle("Log In", forState: UIControlState.Normal)
            
         SignupButton.setTitle("Log In", forState: UIControlState.Normal)
            
         RegisteredText.text = "Not Registered"
        
         LoginSignButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
         ActiveSignUp = false
            
        } else {
          
            SignUpLogin.setTitle("Sign Up", forState: UIControlState.Normal)

            
            SignupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            RegisteredText.text = "Already Registered"
            
            LoginSignButton.setTitle("Log In", forState: UIControlState.Normal)
            
            
            ActiveSignUp = true
   
        
        
        }
        
        
    }

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
// Makes log in appear first
    
        if ActiveSignUp == true {
    
            
            SignUpLogin.setTitle("Log In", forState: UIControlState.Normal)
            
            SignupButton.setTitle("Log In", forState: UIControlState.Normal)
            
            RegisteredText.text = "Not Registered"
            
            LoginSignButton.setTitle("Sign Up", forState: UIControlState.Normal)
        
            ActiveSignUp = false
            
//Remove Text Fields
            
            Name.hidden = !Name.hidden;
            
   
        }
    
}

    override func viewDidAppear(animated: Bool) {
        
       if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("login", sender: self)
            
        
    
        
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
                    }}




