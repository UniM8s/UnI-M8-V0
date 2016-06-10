//
//  SearchedUsers.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 07/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse

class SearchedUsers: UITableViewCell {

    @IBOutlet weak var UserIMG: UIImageView!
    
    @IBOutlet weak var UserName: UILabel!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        let theWidth = UIScreen.mainScreen().bounds.width
        
        contentView.frame = CGRectMake(0, 0, theWidth, 120)
        
        UserIMG.center = CGPointMake(60, 60)
        UserIMG.layer.cornerRadius = UserIMG.frame.size.width/2
        UserIMG.clipsToBounds = true
        
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
