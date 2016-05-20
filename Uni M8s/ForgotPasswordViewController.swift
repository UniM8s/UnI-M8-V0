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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    @IBAction func recoverButtonTapped(sender: AnyObject) {
        
       
            
        
            

    
        
        
    
    }
    
    
    @IBAction func backToLoginButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    
    

}
