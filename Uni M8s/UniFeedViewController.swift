//
//  UniFeedViewController.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 14/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse


class UniFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var ResultsCell: UITableView!
    
    var m8sArray = [String!]()
    
    var resultNameArray = [String]()
    var resultImageFiles = [PFFile]()
    var resultPostArray = [String]()
    var resultHasImageArray = [String]()
    var resultPostImageFile = [PFFile?]()
    
    var refresh: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Width = view.frame.size.width
        let Height = view.frame.size.height
        
        ResultsCell.frame = CGRectMake(0, 0, Width, Height)
        
        let PostButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: #selector(UniFeedViewController.PostButtonClicked))
        
        let UniSearchBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(UniFeedViewController.UniSearchBtnClicked))
        
        let ButtonArray = NSArray(objects: PostButton, UniSearchBtn)
        self.navigationItem.rightBarButtonItems = ButtonArray as? [UIBarButtonItem]
        
        refresh = UIRefreshControl()
        refresh.tintColor = UIColor.blueColor()
        refresh.addTarget(self, action: #selector(UniFeedViewController.refresher), forControlEvents: UIControlEvents.ValueChanged)
        self.ResultsCell.addSubview(refresh)
        
        

  
    }

    func refresher() {
        
        print("refresher table")
        self.refresh.endRefreshing()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.hidesBackButton = true
        
        
    }
        
    override func viewDidAppear(animated: Bool) {
        
        m8sArray.removeAll(keepCapacity: false)
        resultNameArray.removeAll(keepCapacity: false)
        resultImageFiles.removeAll(keepCapacity: false)
        resultPostArray.removeAll(keepCapacity: false)
        resultHasImageArray.removeAll(keepCapacity: false)
        resultImageFiles.removeAll(keepCapacity: false)
        
        
        
        let M8sQuery = PFQuery(className: "M8s")
        M8sQuery.whereKey("User", equalTo: PFUser.currentUser()!.username!)
        
        let objects = try! M8sQuery.findObjects()
        
        for objects in objects {
            
            self.m8sArray.append(objects.objectForKey("UserToM8") as! String)
        }
        let PostQuery = PFQuery(className: "Posts")
        PostQuery.whereKey("UsernameEmail", containedIn: m8sArray)
        PostQuery.addAscendingOrder("createdAt")
        
        PostQuery.findObjectsInBackgroundWithBlock() {
            (objects:[PFObject]?, error:NSError?) -> Void in
        
            
            if error == nil {
                
                for object in objects! {
                    
                    self.resultNameArray.append(object.objectForKey("Name") as! String)
                    self.resultImageFiles.append(object.objectForKey("UserPicIMG") as! PFFile)
                    self.resultPostArray.append(object.objectForKey("PostText") as! String)
                    self.resultHasImageArray.append(object.objectForKey("hasImage") as! String)
                    self.resultImageFiles.append(object.objectForKey("PostedPhotos")as! PFFile)

                    self.ResultsCell.reloadData()
                    
                    
                }
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultNameArray.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if resultHasImageArray[indexPath.row] == "yes" {
            
            return self.view.frame.size.width - 10 

        } else {
        
        
        return 90
            
        }
    
}
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let FeedCell:MainFeedCell = tableView.dequeueReusableCellWithIdentifier("MainFeedCell") as! MainFeedCell
        
        
        FeedCell.postIMG.hidden = true
    
        
         FeedCell.NameLabel.text = self.resultNameArray[indexPath.row]
         FeedCell.PostTxt.text = self.resultPostArray[indexPath.row]
        
        
        resultImageFiles[indexPath.row].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
            
            if error == nil {
                
                let UserImage = UIImage(data: imageData!)
                FeedCell.ImageView.image = UserImage
                
                
            }
        }
        
        
        
        if resultHasImageArray[indexPath.row] == "yes" {
            
            let theWidth = view.frame.size.width
            
            FeedCell.postIMG.frame = CGRectMake(70, 70, theWidth-85, theWidth-85)
            FeedCell.postIMG.hidden = false
            
            resultPostImageFile[indexPath.row]?.getDataInBackgroundWithBlock({ (imageData:NSData?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    let image = UIImage(data: imageData!)
                    FeedCell.postIMG.image = image
                    
                }
            })
            
            
        }
        
   
    return FeedCell
    
    }
    
    
    
    func PostButtonClicked() {
        
        print("Post Pressed")
         performSegueWithIdentifier("CreatePost", sender: self)
        
        
        
        
    }

    func UniSearchBtnClicked(){
        
        print ("UniSearch Pressed")
        performSegueWithIdentifier("UniUsersSegue", sender: self)
    
    
    }
    
    
}

