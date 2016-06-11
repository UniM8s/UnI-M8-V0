//
//  UniSearchUserVC.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 07/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse
var Name = ""

class UniSearchUserVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var UserCell: UITableView!
    
    var nameArray = [String]()
    var userImageFileArray = [PFFile]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let thewidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        UserCell.frame = CGRectMake(0, 0, theHeight, thewidth - 64)
        
        Name = PFUser.currentUser()!.username!
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
        
        let predicate = NSPredicate(format: "username != '"+Name+"'")
        let UserInforQuery = PFQuery(className: "_User", predicate: predicate)
        let Objects = try! UserInforQuery.findObjects()
        
        for Object in Objects {
           let us:PFUser = Object as! PFUser
            self.nameArray.append(Object["names"] as!String)
          // self.userImageFileArray.append(Object["UserPicIMG"] as!PFFile)
            
            self.UserCell.reloadData()
            
          us.revert()
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let profileCell:SearchedUsers = tableView.dequeueReusableCellWithIdentifier("User Cell") as! SearchedUsers
        
        profileCell.UserName.text = self.nameArray[indexPath.row]
        
        userImageFileArray [indexPath.row].getDataInBackgroundWithBlock {
            
            (imageData: NSData?, error:NSError?) -> Void in
            
            if error == nil {
                
                let Image = UIImage(data: imageData!)
                profileCell.UserIMG.image = Image
                
            }
        }
        
        return profileCell
    }
    
    
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


