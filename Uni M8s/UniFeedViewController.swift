//
//  UniFeedViewController.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 14/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit

class UniFeedViewController: UIViewController{

    @IBOutlet weak var ResultsCell: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Width = view.frame.size.width
        let Height = view.frame.size.height
        
        ResultsCell.frame = CGRectMake(0, 0, Width, Height)
        
        
        let PostButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: #selector(UniFeedViewController.PostButtonClicked))
        
    
        
        let ButtonArray = NSArray(objects: PostButton)
        self.navigationItem.rightBarButtonItems = ButtonArray as? [UIBarButtonItem]
        
        
        
        

  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.hidesBackButton = true 
    }

    func PostButtonClicked() {
        
        print("Post Pressed")
        
        
        
        
        
    }


}

