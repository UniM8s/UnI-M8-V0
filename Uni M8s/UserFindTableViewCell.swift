//
//  UserFindTableViewCell.swift
//  Uni M8s
//
//  Created by louis christodoulou on 17/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse

class UserFindTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var UserPicView: UIImageView!

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var UniNameLabel: UILabel!
    
    @IBOutlet weak var M8Button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let Width = UIScreen.mainScreen().bounds.width
        contentView.frame = CGRectMake(0, 0, Width, 65)
        
        UserPicView.center = CGPointMake(32, 32)
        UserPicView.layer.cornerRadius = UserPicView.frame.size.width / 2
        UserPicView.clipsToBounds = true
        
        NameLabel.frame = CGRectMake(70, 10, Width-75, 18)
        M8Button.center = CGPointMake(Width-50, 42)
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // For when the button is clicked to become M8s....
    
    @IBAction func addAM8Button(sender: AnyObject) {
        
        let title = M8Button.titleForState(.Normal)
        
        if title == "Add a M8" {
          
            let M8sObj = PFObject(className: "M8s")
            
            M8sObj["User"] = PFUser.currentUser()!.username
            M8sObj["UserToM8"] = NameLabel.text
            
            
         M8sObj.saveInBackground()
          
            
            M8Button.setTitle("Add a M8", forState: UIControlState.Normal)
            
        }else {
            
            
            let M8query = PFQuery(className: "M8s")
            
            M8query.whereKey("User", equalTo: PFUser.currentUser()!.username!)
            M8query.whereKey("UserToM8", equalTo: NameLabel.text!)
            
            let objects = try! M8query.findObjects()
          
            
            for object in objects {
                
                
            object.deleteInBackground()
                
            }
            
            M8Button.setTitle("Add a M8", forState: UIControlState.Normal)
            

            
        
        }
        
    }

}
