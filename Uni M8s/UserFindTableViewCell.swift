//
//  UserFindTableViewCell.swift
//  Uni M8s
//
//  Created by louis christodoulou on 17/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit

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
    // For when the button is clicked....
    @IBAction func addAM8Button(sender: AnyObject) {
        
        let title = M8Button.titleForState(.Normal)
        
        if title == "m8s" {
          
            let m8sObj = PFObject(className: "m8s")
            
            m8sObj["UserfindVC"] = PFUser.currentUser()?.username
            m8sObj["UserToFollow"] = M8Button
            
            
          //  m8sObj.save()
            
            
        }else {
            
        }
        
    }

}
