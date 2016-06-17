//
//  MainFeedCell.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 14/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit

class MainFeedCell: UITableViewCell {

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var PostTxt: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let Width = UIScreen.mainScreen().bounds.width
        
        contentView.frame = CGRectMake(0, 0, Width, 90)
        
        ImageView.center = CGPointMake(35, 35)
        ImageView.layer.cornerRadius = ImageView.frame.size.width / 2
        ImageView.clipsToBounds = true
        NameLabel.frame = CGRectMake(70, 5, Width-75, 20)
        PostTxt.frame = CGRectMake(70, 22, Width-75, 60)
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
        
        
        
        
    }

}
