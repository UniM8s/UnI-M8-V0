//
//  WriteUniPostVC.swift
//  Uni M8s
//
//  Created by louis christodoulou on 10/06/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit

class WriteUniPostVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var PicIMG: UIImageView!
    @IBOutlet weak var WritePostTXT: UITextView!
    @IBOutlet weak var PostButton: UIButton!
    
    @IBAction func ChooseIMG(sender: UIButton) {
        
        
        let TapPicIMG = UIImagePickerController()
        TapPicIMG.delegate = self
        TapPicIMG.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        TapPicIMG.allowsEditing = true
        self.presentViewController(TapPicIMG, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        PicIMG.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        PostButton.enabled = true    
    
    }
    
    
    @IBAction func PostButtonClicked(sender: AnyObject) {
    
    
    //DismissKeyboard
        self.view.endEditing(true)
        
        let objects = PFObject(className: "PostedPhotos")
        objects["username"] = PFUser.currentUser()!.username
        objects["UserPicIMG"] = PFUser.currentUser()!.valueForKey("UserPicIMG") as! PFFile
        objects["UUID"] = "\(PFUser.currentUser()!.username)\(NSUUID().UUIDString)"
    
        
        
        if WritePostTXT.text.isEmpty{
        
        objects["Title"] = ""
            
        }else{
            
        objects["Title"] = WritePostTXT.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        }
    
    //Send pic to server backend (parse)
        let PictureData = UIImageJPEGRepresentation(PicIMG.image!, 0.5)
        let ImageFile = PFFile(name: "Pictures", data: PictureData!)
        objects["PicIMG"] = ImageFile
        
        
        objects.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            
            if error == nil {
            
            NSNotificationCenter.defaultCenter().postNotificationName("Upload", object: nil)
                //switches to feed tab (3)
                self.tabBarController!.selectedIndex = 0
            
            }
        
            
        }
        
    
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Disable PostButton to prevent post before edit.
        PostButton.enabled = false
        PostButton.backgroundColor = .lightGrayColor()
   

}
    
    
    
    
    
    
    
    //Hide Keyboard Code
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        PicIMG.resignFirstResponder()
        WritePostTXT.resignFirstResponder()
       
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        PicIMG.resignFirstResponder()
        WritePostTXT.resignFirstResponder()
        
        return true
    }
  
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
