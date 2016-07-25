//
//  M8ListChatVC.swift
//  Uni M8s
//
//  Created by Louis Loizou-Christodoulou and Marco Romeo Barbato on 24/07/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse

var User = String()
var M8List = String()


class M8ListChatVC: UITableViewController {

   var userNameArray = [String]()
   var UserPicArray = [PFFile]()
    
    //User added M8's Array
    var M8sListArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = M8List.uppercaseString
        
        LoadM8s()
        
        
    }
    
    
    
    func LoadM8s(){
        
        //Find user M8s
        let M8ListQuery = PFQuery(className: "M8s")
        M8ListQuery.whereKey("M8s", equalTo: User)
        M8ListQuery.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
        
            if error == nil {
                
                
            self.M8sListArray.removeAll(keepCapacity: false)
                
                //find related objects for user M8s
                for object in objects! {
                    
                    self.M8sListArray.append(object.valueForKey("UserToM8") as! String)
                    
                }
            
                //find users m8d
                let M8InfoQuery = PFUser.query()
                M8InfoQuery?.whereKey("User", containedIn: self.M8sListArray)
                M8InfoQuery?.addDescendingOrder("createdAt")
                M8InfoQuery?.findObjectsInBackgroundWithBlock({(objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        self.userNameArray.removeAll(keepCapacity: false)
                        self.UserPicArray.removeAll(keepCapacity: false)
                        
                        //find related objects in user class
                        for object in objects! {
                        
                            self.userNameArray.append(object.objectForKey("names") as! String)
                            self.UserPicArray.append(object.objectForKey("UserPicIMG") as! PFFile)
                            self.tableView.reloadData()
                        
                        }
                    }else{
                        
                    print(error!.localizedDescription)
                    
                    
                    
                    }
            
                
                })
                
            }else{
            
            print(error!.localizedDescription)
            
            }
            
            }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userNameArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let M8Cell: M8sListChatCell = tableView.dequeueReusableCellWithIdentifier("M8Cell") as! M8sListChatCell
        M8Cell.NameLabel.text = userNameArray[indexPath.row]
        UserPicArray[indexPath.row].getDataInBackgroundWithBlock { (data:NSData?, error: NSError?) -> Void in
            
            if error == nil {
                
                M8Cell.UserImage.image = UIImage(data: data!)
                
            }else{
                
                print(error!.localizedDescription)
                
                
            }

        }
        
    
    
        return M8Cell
    }
}