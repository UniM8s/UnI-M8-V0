//
//  ForgotPasswordViewController.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 19/05/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var yourUniversityEmailtextField: UITextField!
    
    @IBAction func RecoverPassButton(sender: UIButton) {
        
        let ForgotemailVar = yourUniversityEmailtextField.text
        PFUser.requestPasswordResetForEmailInBackground(ForgotemailVar!) { (success: Bool, error: NSError?) -> Void in
            
            if (error == nil) {
                
                let alertView = UIAlertController(title: "Password recovery e-mail sent", message: "Please check your e-mail inbox for recovery", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alertView, animated: true, completion: nil)
                
            }else {
                
                let alertView = UIAlertController(title: "Could not found your e-mail", message: "There is no such e-mail in our database", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alertView, animated: true, completion: nil)
                
            }
            
            
            
            
        }
        
        
        
    
    
    
    

    
    }


        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

        
        
    

    
    
    @IBAction func backToLoginButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    
}


