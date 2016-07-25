//
//  M8sListChatCell.swift
//  Uni M8s
//
//  Created by louis christodoulou on 25/07/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit

class M8sListChatCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var AgeLabel: UILabel!
    
    @IBOutlet weak var UniNameLabel: UILabel!
    
    @IBOutlet weak var UserImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
