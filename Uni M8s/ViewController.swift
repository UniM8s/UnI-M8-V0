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

class ViewController: UIViewController, UITextFieldDelegate, PFLogInViewControllerDelegate,PFSignUpViewControllerDelegate
{
    var ActiveSignUp = true
    
     var LogInController = PFLogInViewController.self()
     var SignUpController = PFSignUpViewController.self()
    

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
    
    @IBOutlet var ForgotPassword: UIButton!
    
    
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
            
            
            if  UniversityEmail.text == "" || Password.text == ""  {
                
                
            
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
                    
                    let alertController = UIAlertController(title: "Agree To Terms & Condition to continue", message: "You will not be able to sign up to UNIM8's unless T&C's accepted. Please ensure you read the terms and conditions", preferredStyle: .Alert)
                    
                     //Create the actions
                    let AgreeAction = UIAlertAction(title: "I AGREE", style: UIAlertActionStyle.Default) {
                      UIAlertAction in
                     NSLog("OK Pressed")
                        self.performSegueWithIdentifier("Agreed2termsSegue", sender: self) //change to appropriate segue
                        
                    }
                    let DisagreeAction = UIAlertAction(title: "I DO NOT AGREE", style: UIAlertActionStyle.Cancel) {
                      UIAlertAction in
                      NSLog("Cancel Pressed")
                        
                        
                        self.performSegueWithIdentifier("DidNotAgreeTC", sender: self)
               
                        
                            self.displayAlert("T&C", message: "You must agree to T&C before you can continue") //re-write sectionfor alert TC
                        
                        
                        
                    }
                    
                  //  Add the actions
                    alertController.addAction(AgreeAction)
                    alertController.addAction(DisagreeAction)

                    
                    
                   // Present the controller
                     self.presentViewController(alertController, animated: true, completion: nil)
                    
                
                    
                    
                    
            let user = PFUser()
               
            user["names"] = Name.text
                        
            user.username = UniversityEmail.text // UNI_EMAIL
            user.password = Password.text
            user.email = UniversityEmail.text // NAME
                    
            
            user.signUpInBackgroundWithBlock({ (success, error) in
                
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                
                if error == nil {
                    
                    
                 
                    //Signup was successful
                
              
                    
                } else {
                    
                    if let errorString = error!.userInfo["error"] as? String {
                        
                        errorMessage = errorString
                        
                        self.activityIndicator.stopAnimating()
                        
                        if let message: AnyObject = error!.userInfo["error"] {
                            self.UniversityEmail.text = "\(message)"
                        }
                        
                
                   }
            
                self.displayAlert("Failed Signup", message: errorMessage)
                    
            
            }
                
                })
                    
                
                    
                } else {
                    
                
                PFUser.logInWithUsernameInBackground(UniversityEmail.text!, password: Password.text!, block:
                        { (user,error) -> Void in
                            
          
                            
                            if(PFUser.currentUser()!["emailVerified"].isEqual(1)){
                                
                                //if user["emailVerified"] as! Bool == true {
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.performSegueWithIdentifier(
                                        "login",
                                        sender: self
                                    )
                                }
                            } else {
                                // User needs to verify email address before continuing
                                let alertController = UIAlertController(
                                    title: "Email address verification",
                                    message: "We have sent you an email that contains a link - you must click this link before you can continue.",
                                    preferredStyle: UIAlertControllerStyle.Alert
                                )
                                alertController.addAction(UIAlertAction(title: "OKAY",
                                    style: UIAlertActionStyle.Default,
                                    handler: { alertController in self.SignUpController})
                                )
                                // Display alert
                                self.presentViewController(
                                    alertController,
                                    animated: true,
                                    completion: nil
                                )
                            }
                            
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
        
            
    
     //Email Text Field Constraints - University Email only - ., uni, student, uniname  + ac.uk, fr, edu.au, ....)
            
            let validLogin = isValidEmail(UniversityEmail.text!)
            if validLogin {
                print("User entered valid input")
            } else {
                print("Invalid email address")
            }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[ ., uni, student,coventry,  ]+\\.[ ac.uk, fr, edu.au, edu, ca, shit shit shit fuck piss ]{2,64}"
        
        
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
            
            
            
                
    

    
    @IBAction func Login(sender: AnyObject) {
        
        
        if ActiveSignUp == true {
            
            Name.hidden = !Name.hidden;
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
            
            Name.hidden = false
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
            
            Name.hidden = !Name.hidden;
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
            
            Name.hidden = false
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
        
        
        super.viewDidAppear(animated)

        
       if PFUser.currentUser() != nil {
      
        //Nothing Happens
        
        } else {
            
        
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (object, error) in
            
            let isEmailVerified = PFUser.currentUser()?.objectForKey("EmailVerified")?.boolValue
            
            if isEmailVerified == true
            
            {
              
            
                self.UniversityEmail.text = "Email has been verified"
                
                
            }
            else
            {
               
                
                self.UniversityEmail.text = "Email is not verified"
            
            }
        
        
            
        })
        
        
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
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username:String, password: String) -> Bool {
        
        if !username.isEmpty && !password.isEmpty
        {
            return true
            
        }
            else
        {
            return false
    }


}
 
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
    self.dismissViewControllerAnimated(true, completion: nil)
    
    }

    func logInViewController(logInController: PFLogInViewController, didFailToLgInWithError error: NSError?) {
        print("Failed to login")
    }
        
        //Mark: Sign up
        
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("Failed to sign up......")
}
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("Canceled")
    }
    

    
    


}



    
    
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    


