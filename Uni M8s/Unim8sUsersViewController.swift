//
//  Unim8sUsersViewController.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 15/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse


class Unim8sUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var UserResults: UITableView!
    
    var NameArray = [String]()
    var UniNameArray = [String]()
    var UserImageFile = [PFFile]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let Width = view.frame.size.width
        let Height = view.frame.size.height
        
        UserResults.frame = CGRectMake(0, 0, Width, Height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    
    override func viewDidAppear(animated: Bool) {
        
        NameArray.removeAll(keepCapacity: false)
        UniNameArray.removeAll(keepCapacity: false)
        UserImageFile.removeAll(keepCapacity: false)
        
        let query = PFUser.query()
        
        query!.whereKey("username", notEqualTo: PFUser.currentUser()!.username!)
        
        query!.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?)  -> Void in
            
            if error == nil{
                
                for object in objects!{
                    
                    self.NameArray.append(object.objectForKey("names")as! String)
                    self.UniNameArray.append(object.objectForKey("UniName")as! String)
                    self.UserImageFile.append(object.objectForKey("UserPicIMG")as! PFFile)
                    
                    self.UserResults.reloadData()
                }
            
            
            }
            
        
        
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NameArray.count
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 65
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let Cell:UserFindTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UserFindTableViewCell
        
        Cell.NameLabel.text = self.NameArray[indexPath.row]
        Cell.UniNameLabel.text = self.UniNameArray[indexPath.row]
        
        
        self.UserImageFile[indexPath.row].getDataInBackgroundWithBlock {
            
            (imageData:NSData?, error:NSError?) -> Void in
            
            if error == nil {
                
                let userImage = UIImage(data: imageData!)
                
                Cell.UserPicView.image = userImage
                
                
            }
        }
        
        return Cell
        
        
        
    }
    

}
