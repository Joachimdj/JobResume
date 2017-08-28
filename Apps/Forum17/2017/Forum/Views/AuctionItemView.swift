//
//  AuctionItem.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit

import UIKit
import Kingfisher
import Colours

class AuctionItemView: UIViewController {
    
    var ac = [AuctionItem]() 
    var fullCard = UIScrollView()
    let bidButton = UIButton()
    var titleLabel: UILabel!
    var line: UILabel!
    var who: UITextView!
    var when: UILabel!
    var whereAt: UITextView!
    var headerImage = UIImageView()
    let userImage = UIImageView()
    var cardButton: UIButton!
    var desc: UITextView!
    var currentBid = 0.0
    var bidder = ""
    var row = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
   
        
        
        if(ac[0].bidders != nil)
        {
            for i in ac[0].bidders!
            {
                print(i)
                currentBid = i.value["offer"] as! Double
                bidder =  i.value["name"] as! String
               
            }
            when.text =  "Slutter: \(ac[0].endDate!)"
        }
        
        
        fullCard.frame = CGRect(x: 0,y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-110)
        fullCard.backgroundColor = UIColor.white
        fullCard.layer.borderColor = UIColor.black.cgColor
        fullCard.layer.borderWidth = 2.0
        
        let bImage = UIButton()
        bImage.frame = CGRect(x: -10,y: 0,width: 70,height: 70)
        bImage.setImage(UIImage(named: "ic_close")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        bImage.tintColor = UIColor.black
        bImage.addTarget(self, action: #selector(close(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(bImage)
        
        headerImage.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width,height: 270)
          print("image")
        if(ac[0].image != "")
        {
         let URLHeader = URL(string: (ac[0].image)!)!
            headerImage.kf.setImage(with: URLHeader, placeholder: UIImage(named:"noPic"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
            
        })
        }
        else
        {
            headerImage.image = UIImage(named:"noPic")
        }
          print("userImage")
        if(ac[0].donatorImage != "")
        {
        userImage.frame = CGRect(x: (fullCard.frame.width/2) - 35,y: 235, width: 70, height: 70)
        let URLImage = URL(string: (ac[0].donatorImage)!)!
        userImage.kf.setImage(with: URLImage, placeholder: UIImage(named:"noPic"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
            
        })
        }
        else
        {
            userImage.image = UIImage(named:"noPic")
        }
        userImage.layer.borderWidth = 2.0
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.clipsToBounds = true;
        userImage.layer.cornerRadius = userImage.frame.width/2;
          print("title")
        titleLabel = UILabel(frame: CGRect(x: 35,y: 24, width: UIScreen.main.bounds.width - 70, height: 20))
        
         titleLabel.text = ac[0].name?.uppercased()
         titleLabel.textAlignment = NSTextAlignment.center
         titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 15)
         titleLabel.textColor = UIColor.black
        
        line = UILabel(frame: CGRect(x: 5,y: 360, width: fullCard.frame.size.width-10, height: 4))
        
        line.backgroundColor = UIColor.black
       print("who")
       let attrStr = try! NSAttributedString(
            data: "Doneret af<br>\(ac[0].donator!)".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
      
        who = UITextView(frame: CGRect(x: 5,y: 315, width: fullCard.frame.size.width-10, height: 50))
        who.attributedText = attrStr
        who.textAlignment = NSTextAlignment.center
        who.font = UIFont(name:"HelveticaNeue-bold", size: 14)
        who.textColor = UIColor.black
        
        print("where")
        whereAt = UITextView(frame: CGRect(x: 5,y: 365, width: fullCard.frame.size.width-10, height: 60))
        if(currentBid == 0.0){whereAt.text =  " Startbud: \(ac[0].startBid!) DKK"} else {whereAt.text =  "Nuværende bud: \(currentBid) DKK \n Af \(bidder)" }
        whereAt.textAlignment = NSTextAlignment.center
        whereAt.font = UIFont(name:"HelveticaNeue", size: 18)
        whereAt.textColor = UIColor.black
        
        
          print("when")
        when = UILabel(frame: CGRect(x: 5,y: 420, width: fullCard.frame.size.width-10, height: 20))
        when.textAlignment = NSTextAlignment.center
        when.font = UIFont(name:"HelveticaNeue", size: 15)
        when.textColor = UIColor.black
   
        
        desc = UITextView(frame: CGRect(x: 5,y: 440, width: fullCard.frame.size.width-10, height: 600))
    
        desc.textAlignment = .left
        let attrStr1 = try! NSAttributedString(
            data: (ac[0].desc?.data(using: String.Encoding.unicode, allowLossyConversion: true)!)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        desc.attributedText = attrStr1
        desc.isEditable = false
        desc.font = UIFont (name: "Helvetica Neue", size: 12)
        desc.isScrollEnabled = false
        desc.textColor = UIColor.black
        desc.backgroundColor = UIColor.clear
     
        cardButton  = UIButton(frame: CGRect(x: 0,y: 0, width: fullCard.frame.size.width, height: fullCard.frame.size.height))
        
        self.view.addSubview(titleLabel)
        fullCard.addSubview(headerImage)
        fullCard.addSubview(userImage)
        fullCard.addSubview(who)
        fullCard.addSubview(when)
        fullCard.addSubview(line)
        fullCard.addSubview(whereAt)
        fullCard.addSubview(cardButton)
        fullCard.addSubview(desc)
        
        if(ac[0].status == 0)
        {
        fullCard.contentSize = CGSize(width: fullCard.frame.size.width, height: desc.contentSize.height + 100) 
     
        
        bidButton.frame = CGRect(x: 0,y: UIScreen.main.bounds.height-50, width: UIScreen.main.bounds.width, height: 50)
        bidButton.setTitle("Byd \(currentBid + 50.0) DKK", for: UIControlState.normal)
        bidButton.backgroundColor =  UIColor.infoBlue()
        bidButton.setTitleColor(UIColor.white, for: .normal)
        bidButton.addTarget(self, action: #selector(bid(sender:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(bidButton)
        }
        else
        {
             fullCard.contentSize = CGSize(width: fullCard.frame.size.width, height: desc.contentSize.height + 60)
             fullCard.frame = CGRect(x:0,y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-60)
        }
           self.view.addSubview(fullCard)
        
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Diacose of any resources that can be recreated.
    }
    func close(_ sender:AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }
    func bid(sender:AnyObject)
    {
        let newBid = currentBid + 50.0
        if(AuctionController().makeAnOffer(auction:ac[0],bid:newBid,row:row) == true)
        {
            print("Offer made")
            bidButton.backgroundColor = .moneyGreen()
            bidButton.setTitle("Du har budt \(newBid) DKK", for: .normal) 
        }
        else
        {
            print("error")
        }
    }
}
