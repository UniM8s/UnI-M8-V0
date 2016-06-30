//
//  HomeViewController.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 28/05/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse


class HomeViewController: UICollectionViewController {
    
    var refreshPage : UIRefreshControl!
    
    // size of page 
    var page : Int = 3
    
    var UUIDArray = [String]()
    var PictureArray = [PFFile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // always vertical scroll
        self.collectionView?.alwaysBounceVertical = true

        collectionView?.backgroundColor = .whiteColor()
        // set navigation bar title to current user
        self.navigationItem.title = "UNIM8"
        
      NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("refreshPage"), name: "refreshPage", object: nil)
        
      NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("Posts"), name: "PostedPhoto.png", object: nil)
     
        refreshPage = UIRefreshControl()
        refreshPage.attributedTitle = NSAttributedString(string: "refresh")
        refreshPage.addTarget(self, action: Selector("refreshPage"), forControlEvents: UIControlEvents.ValueChanged)
        self.collectionView?.addSubview(refreshPage)
        
        loadPosts()
    }
    
    func refresh(sender:AnyObject) {
        self.collectionView?.reloadData()
         refreshPage.endRefreshing()
        loadPosts()
        
    }
    
    func UploadedPic(notigications:NSNotification){
        
        loadPosts()
    }
    
    

    func loadPosts() {
        
        let query = PFQuery(className: "PostedPhotos")
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        query.limit = page
        query.findObjectsInBackgroundWithBlock ({ (Objects:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
            
                self.UUIDArray.removeAll(keepCapacity: false)
                self.PictureArray.removeAll(keepCapacity: false)
                
                
                // find objects related to our query request
                for object in Objects! {
                    self.UUIDArray.append(object.valueForKey("UUID") as! String)
                   // self.PictureArray.append(object.valueForKey("PostedPics") as! PFFile)
               }
             
                self.collectionView?.reloadData()
            } else {
                print(error!.localizedDescription)
            }
            })
        
        
    }
    
    
        override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PictureArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let picCell = collectionView.dequeueReusableCellWithReuseIdentifier("PicCell", forIndexPath: indexPath) as! PostedPics
        
        PictureArray[indexPath.row].getDataInBackgroundWithBlock { (data:NSData?, error: NSError?) -> Void in
            if error == nil {
                picCell.PostedPic.image = UIImage(data: data!)
                
            } else {
                print(error!.localizedDescription)
            }
        }
        
        return picCell
        
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        
        let headerInfo = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderInfo", forIndexPath: indexPath) as! HeaderInfoView
        
        headerInfo.NameLabel.text = (PFUser.currentUser()?.objectForKey("names") as? String)?.uppercaseString
        headerInfo.Gender.text = PFUser.currentUser()?.objectForKey("Gender") as? String
        headerInfo.sizeToFit()
        headerInfo.Biotext.text = PFUser.currentUser()?.objectForKey("Bio") as? String
        headerInfo.Biotext.sizeToFit()
        headerInfo.EditProfileChat.setTitle("edit profile", forState: UIControlState.Normal)
      
        
        
        let userPicQuery = PFUser.currentUser()?.objectForKey("UserPicIMG") as! PFFile
        userPicQuery.getDataInBackgroundWithBlock { (data:NSData?, error:NSError?) -> Void in
            headerInfo.ProfileImage.image = UIImage(data: data!)
        }
 
 
 
        return headerInfo
 
        
        
        
    }
    

}
