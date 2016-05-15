//
//  ViewController.swift
//  Uni M8s
//
//  Created by louis christodoulou on 03/05/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, UITextFieldDelegate
{
    var ActiveSignUp = true

    @IBOutlet var Name: UITextField! //IMPORTANT NOTES ======> Rename UNI-EMAIL - Restoration ID
    
    @IBOutlet var UniversityEmail: UITextField!   //IMPORTANT NOTES ======> Rename as NAME - Restoration ID
    
    @IBOutlet var Password: UITextField!
    
    @IBOutlet var ConfirmPassword: UITextField!
   
//Button Actions
    
    @IBOutlet var SignUpLogin: UIButton! //duplicate

    @IBOutlet var SignupButton: UIButton!
  
    @IBOutlet var RegisteredText: UILabel!
    
    @IBOutlet var LoginSignButton: UIButton!
    
    
//Sign Up Section to be hidden & Utilized
    
    @IBOutlet var UniName: UITextField!
    
    @IBOutlet var Gender: UITextField!
    
    @IBOutlet var InterestSwitch: UISwitch!
    
    
//Labels to be Hidden + Switch
    
    @IBOutlet var WhoAreYouInt: UILabel!
    
    @IBOutlet var Men: UILabel!
    
    @IBOutlet var Women: UILabel!
    
    
    
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
            
            
            
            if  Name.text == "" || Password.text == ""  {
            
            displayAlert("Error In Form", message: "oops! Please enter a valid university email, and password")
            
            
            
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
            user.username = Name.text // UNI_EMAIL
            user.password = Password.text
            user.email = UniversityEmail.text // NAME
            
            
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
                    
                
                PFUser.logInWithUsernameInBackground(Name.text!, password: Password.text!, block:
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
            
            UniversityEmail.hidden = !Name.hidden;
            UniName.hidden = !UniName.hidden;
            Gender.hidden = !Gender.hidden;
            WhoAreYouInt.hidden = !WhoAreYouInt.hidden;
            Men.hidden = !Men.hidden;
            Women.hidden = !Women.hidden;
            InterestSwitch.hidden = !InterestSwitch.hidden;
            ConfirmPassword.hidden = !ConfirmPassword.hidden;
            
            
            
         SignUpLogin.setTitle("Log In", forState: UIControlState.Normal)
            
         SignupButton.setTitle("Log In", forState: UIControlState.Normal)
            
         RegisteredText.text = "Not Registered"
        
         LoginSignButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
         ActiveSignUp = false
            
            
            
        } else {
            
            UniversityEmail.hidden = false
            UniName.hidden = !UniName.hidden;
            Gender.hidden = !Gender.hidden;
            WhoAreYouInt.hidden = !WhoAreYouInt.hidden;
            Men.hidden = !Men.hidden;
            Women.hidden = !Women.hidden;
            InterestSwitch.hidden = !InterestSwitch.hidden;
            ConfirmPassword.hidden = !ConfirmPassword.hidden;
            
          
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
            
            UniversityEmail.hidden = !Name.hidden;
            UniName.hidden = !UniName.hidden;
            Gender.hidden = !Gender.hidden;
            WhoAreYouInt.hidden = !WhoAreYouInt.hidden;
            Men.hidden = !Men.hidden;
            Women.hidden = !Women.hidden;
            InterestSwitch.hidden = !InterestSwitch.hidden;
            ConfirmPassword.hidden = !ConfirmPassword.hidden;
            
            
            SignUpLogin.setTitle("Log In", forState: UIControlState.Normal)
            
            SignupButton.setTitle("Log In", forState: UIControlState.Normal)
            
            RegisteredText.text = "Not Registered"
            
            LoginSignButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            ActiveSignUp = false
            
        } else {
            
            UniversityEmail.hidden = false
            UniName.hidden = !UniName.hidden;
            Gender.hidden = !Gender.hidden;
            WhoAreYouInt.hidden = !WhoAreYouInt.hidden;
            Men.hidden = !Men.hidden;
            Women.hidden = !Women.hidden;
            InterestSwitch.hidden = !InterestSwitch.hidden;
            ConfirmPassword.hidden = !ConfirmPassword.hidden;
            
            
            SignUpLogin.setTitle("Sign Up", forState: UIControlState.Normal)
            
            
            SignupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            RegisteredText.text = "Already Registered"
            
            LoginSignButton.setTitle("Log In", forState: UIControlState.Normal)
            
            
            ActiveSignUp = true

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
                    }


    //Hide Keyboard Code
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        Name.resignFirstResponder()
        UniversityEmail.resignFirstResponder()
        Password.resignFirstResponder()
        ConfirmPassword.resignFirstResponder()
        UniName.resignFirstResponder()
        Gender.resignFirstResponder()
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        Name.resignFirstResponder()
        UniversityEmail.resignFirstResponder()
        Password.resignFirstResponder()
        ConfirmPassword.resignFirstResponder()
        UniName.resignFirstResponder()
        Gender.resignFirstResponder()
        
        return true
    }
    



}




