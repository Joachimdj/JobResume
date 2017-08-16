//
//  AuctionInfo.swift
//  Forum
//
//  Created by Joachim Dittman on 05/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseStorage

class AuctionInfo: UIViewController {
    
    var fullCard = UIScrollView()
    let buttonView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let SP = auctionContainer[selectedItem]
        self.view.backgroundColor = UIColor(red: 142.0/255, green: 122.0/255, blue: 183.0/255, alpha: 1.0)
        var title: UILabel!
        var line: UILabel!
        var who: UITextView!
        var when: UILabel!
        var whereAt: UILabel!
        let headerImage = UIImageView()
        let userImage = UIImageView()
        var cardButton: UIButton!
        var desc: UITextView!
        
        fullCard.frame = CGRect(x: 40,y: 60, width: screenSize.width-80, height: screenSize.height-60)
        fullCard.backgroundColor = UIColor.white
        fullCard.layer.borderColor = UIColor.black.cgColor
        fullCard.layer.borderWidth = 2.0
        
        let bImage = UIButton()
        bImage.frame = CGRect(x: -10,y: 0,width: 70,height: 70)
        bImage.setImage(UIImage(named: "ic_close")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        bImage.tintColor = UIColor.white
        bImage.addTarget(self, action: #selector(ProgramInfo.close(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(bImage)
        
        headerImage.frame = CGRect(x: 0,y: 0,width: screenWidth-80,height: 250)
        let URLHeader = URL(string: SP.image)!
        headerImage.kf.setImage(with: URLHeader, placeholder: UIImage(named: "bifrost"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
            
        })
        userImage.frame = CGRect(x: (fullCard.frame.width/2) - 50,y: 200, width: 100, height: 100)
        userImage.image = UIImage(named: "bifrost")
        let URLImage = URL(string: SP.donatorImage)!
        userImage.kf.setImage(with: URLImage, placeholder: UIImage(named: "bifrost"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
                
            })
       
        userImage.layer.borderWidth = 2.0
        userImage.layer.borderColor = UIColor.lightGray.cgColor
        userImage.clipsToBounds = true;
        userImage.layer.cornerRadius = userImage.frame.width/2;
         
        title = UILabel(frame: CGRect(x: 0,y: 23, width: screenWidth, height: 20))
     
        title.text = SP.name
        title.textAlignment = NSTextAlignment.center
        title.font = UIFont(name:"HelveticaNeue-Bold", size: 15)
        title.textColor = UIColor.white
        
        line = UILabel(frame: CGRect(x: 5,y: 340, width: fullCard.frame.size.width-10, height: 4))
        
        line.backgroundColor = UIColor.lightGray
        
        let attrStr = try! NSAttributedString(
            data: "Doneret af<br>\(SP.donator)".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
       
        who = UITextView(frame: CGRect(x: 5,y: 295, width: fullCard.frame.size.width-10, height: 50))
        who.attributedText = attrStr
        who.textAlignment = NSTextAlignment.center
        who.font = UIFont(name:"HelveticaNeue-bold", size: 14)
        who.textColor = UIColor.black
        
        when = UILabel(frame: CGRect(x: 5,y: 390, width: fullCard.frame.size.width-10, height: 20))
        when.text =  "Slutter: \(SP.endDate)"
        when.textAlignment = NSTextAlignment.center
        when.font = UIFont(name:"HelveticaNeue", size: 15)
        when.textColor = UIColor.black
        
        whereAt = UILabel(frame: CGRect(x: 5,y: 360, width: fullCard.frame.size.width-10, height: 20))
        whereAt.text =  " Startbud: \(SP.bid) DKK"
        whereAt.textAlignment = NSTextAlignment.center
        whereAt.font = UIFont(name:"HelveticaNeue", size: 18)
        whereAt.textColor = UIColor.black
        
        desc = UITextView(frame: CGRect(x: 5,y: 380, width: fullCard.frame.size.width-10, height: 600))
        
        desc.textAlignment = .left
        let attrStr1 = try! NSAttributedString(
            data: SP.desc.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        desc.attributedText = attrStr1
        desc.isEditable = false
        desc.font = UIFont (name: "Helvetica Neue", size: 12)
        desc.isScrollEnabled = false
        desc.textColor = UIColor.black
        desc.backgroundColor = UIColor.clear
        
        cardButton  = UIButton(frame: CGRect(x: 0,y: 0, width: fullCard.frame.size.width, height: fullCard.frame.size.height))
        
        fullCard.addSubview(headerImage)
        fullCard.addSubview(who)
        fullCard.addSubview(userImage)
        self.view.addSubview(title)
        fullCard.addSubview(line)
        
      //  fullCard.addSubview(when)
       fullCard.addSubview(whereAt)
        fullCard.addSubview(cardButton)
        fullCard.addSubview(desc)
        
        fullCard.contentSize = CGSize(width: fullCard.frame.size.width, height: desc.contentSize.height + 100)
        
        
        self.view.addSubview(fullCard)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
    }
    func close(_ sender:AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
