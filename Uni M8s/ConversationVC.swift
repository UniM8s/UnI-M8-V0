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

class ConversationVC: UIViewController {

    @IBOutlet weak var ResultScrollView: UIScrollView!
    
    
    @IBOutlet weak var FrameTextView: UIView!
    
    
    @IBOutlet weak var LineLabel: UILabel!
    
    
    @IBOutlet weak var MessageTextView: UITextView!
   
    
    @IBOutlet weak var SendMessageBtn: UIButton!
    
    
    
    var scrolViewStartY:CGFloat = 0
    var FrameTextStartY:CGFloat = 0
    
    let MessageLabel = UILabel(frame: CGRectMake(5, 8, 200, 20))
    
    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
