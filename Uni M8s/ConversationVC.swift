//
//  ConversationVC.swift
//  Uni M8s
//
//  Created by louis christodoulou on 05/08/2016.
//  Copyright © 2016 Louis Loizou-Christodoulou & Marco Romeo Barbato Apps. All rights reserved.
//

import UIKit
import Parse


var M8Name = ""
var M8ProfileName = ""

class ConversationVC: UIViewController, UIScrollViewDelegate, UITextViewDelegate{

    @IBOutlet weak var ResultScrollView: UIScrollView!
    @IBOutlet weak var FrameTextView: UIView!
    @IBOutlet weak var LineLabel: UILabel!
    @IBOutlet weak var MessageTextView: UITextView!
    @IBOutlet weak var SendMessageBtn: UIButton!
    
    
    
    var scrolViewStartY:CGFloat = 0
    var FrameTextStartY:CGFloat = 0
    
    let MessageLabel = UILabel(frame: CGRectMake(5, 8, 200, 20))
    
    var messageX:CGFloat = 37.0
    var messageY:CGFloat = 26.0
    var FrameX:CGFloat = 32.0
    var FrameY:CGFloat = 21.0
    var ImageX:CGFloat = 3
    var ImageY:CGFloat = 3
    
    
    var messageArray = [String]()
    var senderArray = [String]()
    
    var myImage:UIImage? = UIImage()
    var M8Image:UIImage? = UIImage()
    var ResultImageF1 = [PFFile]()
    var ResultImageF2 = [PFFile]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        
        let Width = view.frame.size.width
        let Height = view.frame.size.height
        
        ResultScrollView.frame = CGRectMake(0, 64, Width, Height-114)
        ResultScrollView.layer.zPosition = 20
        
        FrameTextView.frame = CGRectMake(0, ResultScrollView.frame.maxY, Width, 50)
        LineLabel.frame = CGRectMake(0, 0, Width, 1)
        MessageTextView.frame = CGRectMake(2, 1, self.FrameTextView.frame.size.width-52, 48)
        SendMessageBtn.center = CGPointMake(FrameTextView.frame.size.width-30, 24)
        
        scrolViewStartY = self.ResultScrollView.frame.origin.y
        FrameTextStartY = self.FrameTextView.frame.origin.y
       
        self.title = M8Name
        
        MessageLabel.text = "Type A Message..."
        MessageLabel.backgroundColor = UIColor.clearColor()
        MessageLabel.textColor = UIColor.lightGrayColor()
        MessageTextView.addSubview(MessageLabel)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown"), name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide"), name: UIKeyboardWillHideNotification, object: nil)
        
        let TapScrollViewGesture = UITapGestureRecognizer(target: self, action: "didTapScrollView")
        TapScrollViewGesture.numberOfTapsRequired = 1
        ResultScrollView.addGestureRecognizer(TapScrollViewGesture)
        
        
    }

    
    
    func didTapScrollView() {
    
    self.view.endEditing(true)
    
    
    }
    
    func textViewDidChange(textView: UITextView) {
        if !MessageTextView.hasText() {
        
            self.MessageLabel.hidden = false
            
        }else{
            
            self.MessageLabel.hidden = true
            
            
        }
    }
    
    
    func textViewDidEndEditing(textView: UITextView) {
        if !MessageTextView.hasText() {
        
            self.MessageLabel.hidden = false
        
        }
    }
    
    
    
    func keyboardWasShown(notification:NSNotification) {
        
        let dict:NSDictionary = notification.userInfo!
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect:CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
            
            self.ResultScrollView.frame.origin.y = self.scrolViewStartY - rect.height
            self.FrameTextView.frame.origin.y = self.FrameTextStartY - rect.height
            
            let BottomOffset:CGPoint = CGPointMake(0, self.ResultScrollView.contentSize.height - self.ResultScrollView.bounds.size.height)
            self.ResultScrollView.setContentOffset(BottomOffset, animated: false)
            
            }, completion: {
                (finished: Bool) in
        
        
      })
    
    }

    func keyboardWillHide(notification:NSNotification) {
        
        let dict:NSDictionary = notification.userInfo!
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect:CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
            
            self.ResultScrollView.frame.origin.y = self.scrolViewStartY
            self.FrameTextView.frame.origin.y = self.FrameTextStartY
            
            let BottomOffset:CGPoint = CGPointMake(0, self.ResultScrollView.contentSize.height - self.ResultScrollView.bounds.size.height)
            self.ResultScrollView.setContentOffset(BottomOffset, animated: false)
            
            }, completion: {
                (finished: Bool) in
                
                
        })

        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let Query = PFQuery(className: "_User")
         Query.whereKey("username", equalTo: User!)
        let Objects = try! Query.findObjects()
        
        self.ResultImageF1.removeAll(keepCapacity: false)
        
      for Object in Objects{
        
        self.ResultImageF1.append(Object["UserPicIMG"] as! PFFile)
        self.ResultImageF1[0].getDataInBackgroundWithBlock{
        
        
            (imageData:NSData?, error: NSError?) -> Void in
            
            
            if error == nil {
            
            
                self.myImage = UIImage(data: imageData!)
                
                let Query2 = PFQuery(className: "_User")
                Query2.whereKey("username", equalTo: M8Name)
                let Object2 = try! Query2.findObjects()
                
                
                
                self.ResultImageF2.removeAll(keepCapacity: false)
            
                for Object in Object2{
                
                self.ResultImageF2.append(Object["UserPicIMG"] as! PFFile)
                    self.ResultImageF2[0].getDataInBackgroundWithBlock{
                    
                        (imageData:NSData?, error: NSError?) -> Void in
                        
                        if error == nil{
                        
                        self.M8Image = UIImage(data: imageData!)
                            
                            self.refreshChatResults()
                        
                        }
                        
                     }
                
                
                  }
             
            
               }
        
        
            }
        
        
        
        }
    
    
    
    }
    
    
    func refreshChatResults() {
        
        let Width = view.frame.size.width
        let Height = view.frame.size.height
        
        messageX = 37.0
        messageY = 26.0
        FrameX = 32.0
        FrameY = 21.0
        ImageX = 3
        ImageY = 3
        
        messageArray.removeAll(keepCapacity: false)
        senderArray.removeAll(keepCapacity: false)
        
        let Predicate1 = NSPredicate(format: "sender = %@ AND recieved = %@", User!, M8Name)
        let ChatQuery1: PFQuery = PFQuery(className: "messages", predicate: Predicate1)
        
        let Predicate2 = NSPredicate(format: "sender = %@ AND recieved = %@", M8Name, User!)
        let ChatQuery2: PFQuery = PFQuery(className: "messages", predicate: Predicate2)
        
        let Query = PFQuery.orQueryWithSubqueries([ChatQuery1,ChatQuery2])
        Query.addAscendingOrder("createdAt")
        Query.findObjectsInBackgroundWithBlock {
            (objects:[PFObject]? , error: NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    
                    self.senderArray.append(object.objectForKey("sender") as! String)
                    self.messageArray.append(object.objectForKey("messages") as! String)
                }
                
                
                for subView in self.ResultScrollView.subviews {
                
                subView.removeFromSuperview()
                    
                
                
                
                }
                
               for i in 0.stride(through: self.messageArray.count-1, by: 1 ) {
                    
                    if self.senderArray[i] == User {
                        
                        let messageLabel:UILabel = UILabel()
                        messageLabel.frame = CGRectMake(0, 0, self.ResultScrollView.frame.size.width-94, CGFloat.max)
                        messageLabel.backgroundColor = UIColor.blueColor()
                        messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLabel.textAlignment = NSTextAlignment.Left
                        messageLabel.numberOfLines = 0
                        messageLabel.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLabel.textColor = UIColor.whiteColor()
                        messageLabel.text = self.messageArray[i]
                        messageLabel.sizeToFit()
                        messageLabel.layer.zPosition = 20
                        messageLabel.frame.origin.x = (self.ResultScrollView.frame.size.width - self.messageX) -
                             messageLabel.frame.size.width
                        messageLabel.frame.origin.y = self.messageY
                        self.ResultScrollView.addSubview(messageLabel)
                        self.messageY += messageLabel.frame.size.height + 30
                        
                        
                        let FrameLabel: UILabel = UILabel()
                        FrameLabel.frame.size = CGSizeMake(messageLabel.frame.size.width+10, messageLabel.frame.size.height+10 )
                        FrameLabel.frame.origin.x = (self.ResultScrollView.frame.size.width-self.FrameX) - FrameLabel.frame.size.width
                        FrameLabel.frame.origin.y = self.FrameY
                        FrameLabel.backgroundColor = UIColor.blackColor()
                        FrameLabel.layer.masksToBounds = true
                        FrameLabel.layer.cornerRadius = 10
                        self.ResultScrollView.addSubview(FrameLabel)
                        self.FrameY += FrameLabel.frame.size.height + 20
                        
                        let Image:UIImageView = UIImageView()
                        Image.image = self.myImage
                        Image.frame.size = CGSizeMake(34, 34)
                        Image.frame.origin.x = (self.ResultScrollView.frame.size.width - self.ImageX) - Image.frame.size.width
                        Image.frame.origin.y = self.ImageY
                        Image.layer.zPosition = 30
                        Image.layer.cornerRadius = Image.frame.size.width/2
                        Image.clipsToBounds = true
                        self.ResultScrollView.addSubview(Image)
                        self.ImageY += FrameLabel.frame.size.height + 20
                        
                        
                        self.ResultScrollView.contentSize = CGSizeMake(Width, self.messageY)
                        
                        
                    
                    
                    }else {
                        
                        let messageLabel:UILabel = UILabel()
                        messageLabel.frame = CGRectMake(0, 0, self.ResultScrollView.frame.size.width-94, CGFloat.max)
                        messageLabel.backgroundColor = UIColor.groupTableViewBackgroundColor()
                        messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLabel.textAlignment = NSTextAlignment.Left
                        messageLabel.numberOfLines = 0
                        messageLabel.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLabel.textColor = UIColor.blueColor()
                        messageLabel.text = self.messageArray[i]
                        messageLabel.sizeToFit()
                        messageLabel.layer.zPosition = 20
                        messageLabel.frame.origin.x = self.messageX
                            
                        messageLabel.frame.origin.y = self.messageY
                        self.ResultScrollView.addSubview(messageLabel)
                        self.messageY += messageLabel.frame.size.height + 30
                        
                        let FrameLabel: UILabel = UILabel()
                        FrameLabel.frame = CGRectMake(self.FrameX, self.FrameY, messageLabel.frame.size.width+10, messageLabel.frame.size.height+10)
                        FrameLabel.backgroundColor = UIColor.groupTableViewBackgroundColor()
                        FrameLabel.layer.masksToBounds = true
                        FrameLabel.layer.cornerRadius = 10
                        self.ResultScrollView.addSubview(FrameLabel)
                        self.FrameY += FrameLabel.frame.size.height + 20

                        let Image:UIImageView = UIImageView()
                        Image.image = self.M8Image
                        Image.frame = CGRectMake(self.ImageX, self.ImageY, 34, 34)
                        Image.layer.zPosition = 30
                        Image.layer.cornerRadius = Image.frame.size.width/2
                        Image.clipsToBounds = true
                        self.ResultScrollView.addSubview(Image)
                        self.ImageY += FrameLabel.frame.size.height + 20
                        

                        
                        self.ResultScrollView.contentSize = CGSizeMake(Width, self.messageY)
                        
                        
                        
                        
                    }
                    
                    
                    let BottomOffset:CGPoint = CGPointMake(0, self.ResultScrollView.contentSize.height - self.ResultScrollView.bounds.size.height)
                    self.ResultScrollView.setContentOffset(BottomOffset, animated: false)
                    
                    
                }
                
            }
            
        }
        
        
        
    }
 
    
    
    @IBAction func sendBtnClicked(sender: AnyObject) {
        
        if MessageTextView.text == "" {
        
        print("no Text")
            
        }else{
            
            let MessageTable = PFObject(className: "messages")
            MessageTable["sender"] = User
            MessageTable["recieved"] = M8ProfileName
            MessageTable["messages"] = self.MessageTextView.text
            MessageTable.saveInBackgroundWithBlock{
                (success: Bool, error:NSError?) -> Void in
                
                if success == true{
                
                
                print("Message Sent")
                    self.MessageTextView.text == ""
                    self.MessageLabel.hidden = false
                    self.refreshChatResults()
                
                
                }
            
            
            }
        
        
        }
        
        
        
        
    }
    

}
