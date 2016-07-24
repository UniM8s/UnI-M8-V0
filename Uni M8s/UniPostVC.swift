//
//  UniPostVC.swift
//  Uni M8s
//
//  Created by Marco  Barbato on 14/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse

class UniPostVC: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var PostText: UITextView!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var ChooseImageButton: UIButton!
    @IBOutlet weak var CharacterLimit: UILabel!
    @IBOutlet weak var PostBtn: UIButton!
    
    var hasImage = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theWidth = view.frame.size.width
        //let theHeight = view.frame.size.height
        
        PostText.frame = CGRectMake(5, 65, theWidth-10, 78)
        CharacterLimit.frame = CGRectMake(10, 150, 100, 30)
        PostBtn.center = CGPointMake(theWidth-40, 170)
        ChooseImageButton.center = CGPointMake(46, 210)
        PostImage.frame = CGRectMake(5, 226, theWidth-10, theWidth-10)
         PostBtn.enabled = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelClicked(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    func textViewDidChange(textView: UITextView) {
    
            
        let lim = PostText.text.characters.count
        //let len = count(messageTxt.text.utf16)
        //var len = messageTxt.text.utf16Count
        let diff = 90 - lim
        
        if diff < 0 {
            
            CharacterLimit.textColor = UIColor.redColor()
        } else {
            
            CharacterLimit.textColor = UIColor.blackColor()
        }
        
        CharacterLimit.text = "\(diff)"
        
        if diff == 90{
            
            //post button disabled
           PostBtn.enabled = false
        }else {
            PostBtn.enabled = true
        }
        
    }
    
    
    @IBAction func PostButtonClicked(sender: AnyObject) {
        
        var PostTXT = PostText.text
        let lim = CharacterLimit.text!.characters.count
        //var len = messageTxt.text.utf16Count
        
        if lim > 90 {
            
            PostTXT = PostTXT.substringToIndex(PostTXT.startIndex.advancedBy(90))
            
        }
        
     
        let PostObj = PFObject(className: "Posts")
        
    
        PostObj["UsernameEmail"] = PFUser.currentUser()!.username
        PostObj["Name"] = PFUser.currentUser()!.valueForKey("names") as! String
        PostObj["UserPicIMG"] = PFUser.currentUser()!.valueForKey("UserPicIMG") as! PFFile
        PostObj["PostText"] = PostTXT
        
        if hasImage == true {
            
            PostObj["hasImage"] = "yes"
            
            let imageData = UIImagePNGRepresentation(self.PostImage.image!)
            let imageFile = PFFile(name: "PostedPhoto.png", data: imageData!)
            PostObj["PostedPhotos"] = imageFile
            
        } else {
            
            PostObj["hasImage"] = "no"
            
        }
        
        
    PostObj.saveInBackground()
        
        print("Posted To UniFeed!!")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let theInfo:NSDictionary = info as NSDictionary
        
        let image:UIImage = theInfo.objectForKey(UIImagePickerControllerEditedImage) as! UIImage
        PostImage.image = image
        
        hasImage = true
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func ChooseIMGClicked(sender: AnyObject) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    
}

