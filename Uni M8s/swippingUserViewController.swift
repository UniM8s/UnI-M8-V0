//
//  swippingUserViewController.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 03/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse

class swippingUserViewController: UIViewController {
    
    

    @IBOutlet weak var userImage1: UIImageView!
    @IBOutlet weak var acceptOrRejectUserLabel: UILabel!
    
    func wasDragged(likeDislikeUserGesture: UIPanGestureRecognizer) {
        
        let translation = likeDislikeUserGesture.translationInView(self.view)
        let userImage = likeDislikeUserGesture.view!

        
        userImage.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = userImage.center.x - self.view.bounds.width / 2
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        userImage.transform = stretch
        
        
        if likeDislikeUserGesture.state == UIGestureRecognizerState.Ended {
            
            if userImage.center.x < 100 {
                
                print("Not chosen")
                
            } else if userImage.center.x > self.view.bounds.width - 100 {
                
                print("Chosen")
                
            }
            
            rotation = CGAffineTransformMakeRotation(0)
            
            stretch = CGAffineTransformScale(rotation, 1, 1)
            
            userImage.transform = stretch
            
            userImage.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
        }
        
        
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let likeDislikeUserGesture = UIPanGestureRecognizer(target: self, action: Selector("userImage1"))
        userImage1.addGestureRecognizer(likeDislikeUserGesture)
        
        userImage1.userInteractionEnabled = true
        
        
    
        
        let query = PFUser.query()
        
        var InterestedIn = "male"
        
        
        if (PFUser.currentUser()?["interestOnWomen"])! as! Bool == true {
            
            InterestedIn = "female"
            
        }
        var isFemale = true
        if (PFUser.currentUser()?["Gender"])! as! String == "male" {
            
            isFemale = false
        }
        
        
        query!.whereKey("Gender", equalTo:InterestedIn)
        query!.whereKey("interestOnWomen", equalTo: isFemale)
        query!.limit = 1
        
        
        query?.findObjectsInBackgroundWithBlock({( objects: [PFObject]?, error: NSError?) -> Void in
    
            
            if error != nil {
                
                print(error)
                
                
            } else if let objects = objects! as [PFObject]? {
                
                for object in objects{
                
                    let imagefile = object["UserPicIMG"] as! PFFile
                    
                    imagefile.getDataInBackgroundWithBlock {
                        (imageData: NSData?,error: NSError?) -> Void in
                        
                        if error != nil {
                            print(error)
                        }else {
        
                            if let data = imageData {
                                
                                self.userImage1.image = UIImage(data: data)
                                
                                
                                
                            }
                    
    
               

               }
            }
         }

      }
            
       }
 
    )
}

    
 override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
   }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logOut" {
            
            PFUser.logOut()
        }
        
    
    }
    

        }
