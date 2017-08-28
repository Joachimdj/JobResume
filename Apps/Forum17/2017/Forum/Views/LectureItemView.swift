//
//  LectureItem.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit

class LectureItemView: UIViewController {
    
    var lc = [Lecture]()
    var fullCard = UIScrollView()
    let signupButton = UIButton() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        var titleLabel: UILabel!
        var line: UILabel!
        var who: UITextView!
        var when: UILabel!
        var whereAt: UILabel!
        let userImage = UIImageView()
        var cardButton: UIButton!
        let headerImage = UIImageView()
       
        var desc: UITextView!
        let participantView = UIScrollView(frame: CGRect(x: 0,y: 210, width: UIScreen.main.bounds.width, height: 80))
        fullCard.frame = CGRect(x:0,y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-60)
        
        
        fullCard.backgroundColor = UIColor.white
        fullCard.layer.borderColor = UIColor.black.cgColor
        fullCard.layer.borderWidth = 2.0
        
        let bImage = UIButton()
        bImage.frame = CGRect(x: -10,y: 0,width: 70,height: 70)
        bImage.setImage(UIImage(named: "ic_close")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        bImage.tintColor = UIColor.black
        bImage.addTarget(self, action: #selector(close(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(bImage)
        print("titleLabel")
        titleLabel = UILabel(frame: CGRect(x:20,y: 24, width: UIScreen.main.bounds.width - 40, height: 20))
        
        titleLabel.text = lc[0].name?.uppercased()
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 15)
        titleLabel.textColor = UIColor.black
        
        print("headerImage")
        headerImage.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width,height: 250)
        print(lc[0].headerImage!)
        if(lc[0].headerImage != "")
        {
            let URLHeader = URL(string: (lc[0].headerImage)!)!
            headerImage.kf.setImage(with: URLHeader, placeholder: UIImage(named:"noPic"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
                
            })
        }
        else
        {
            headerImage.image = UIImage(named:"noPic")
        }
        var start:CGFloat = 0
        var k = 0
        var lecturerString = ""
        
        if(lc[0].lecturer != nil)
        {
            let a = lc[0].lecturer?.count
            let calculateStart = (Int((UIScreen.main.bounds.width/2)) - (a! * 35))
            start = CGFloat(calculateStart)
            print("lecture")
            
            for i in lc[0].lecturer! {
                
                let image = UIImageView()
                image.frame =  CGRect(x: start,y: 5, width: 60, height: 60)
                if(i.value["image"] != "")
                {
                    let URL = Foundation.URL(string: i.value["image"]!)!
                    image.backgroundColor = .white
                    image.kf.setImage(with: URL, placeholder:UIImage(named:"icon"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
                        
                    })
                }
                else
                {
                    image.backgroundColor = .white
                    image.image = UIImage(named:"icon")
                }
                print("lecture")
                image.layer.borderWidth = 2.0
                image.layer.borderColor = UIColor.lightGray.cgColor
                image.clipsToBounds = true;
                image.layer.cornerRadius = image.frame.width/2;
                
                participantView.addSubview(image)
                print("lecture")
                if(i.value["name"] != "")
                {
                    if(a == 1){lecturerString += "\(i.value["name"]!)"} else
                    {
                        if(k <  a!-2){lecturerString += "\(i.value["name"]!), "}
                        else
                        {
                            if(k <  a!-1){lecturerString += "\(i.value["name"]!) "} else {lecturerString += "& \(i.value["name"]!)"}
                        }
                    }
                }
                k += 1
                start += 70
                
            }
        } 
        line = UILabel(frame: CGRect(x: 5,y: 340, width: fullCard.frame.size.width-10, height: 4))
        
        line.backgroundColor = UIColor.lightGray
        
        let attrStr = try! NSAttributedString(
            data: "Af \(lecturerString)".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        print("who")
        who = UITextView(frame: CGRect(x: 5,y: 265, width: fullCard.frame.size.width-10, height: 50))
        who.attributedText = attrStr
        who.textAlignment = NSTextAlignment.center
        who.font = UIFont(name:"HelveticaNeue-bold", size: 14)
        who.textColor = UIColor.black
        print("when")
        when = UILabel(frame: CGRect(x: 5,y: 318, width: fullCard.frame.size.width-10, height: 20))
        when.text =  "\(String(describing: lc[0].startTime!)) - \(String(describing: lc[0].endTime!))"
        when.textAlignment = NSTextAlignment.right
        when.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        when.textColor = UIColor.black
        print("whereAt")
        whereAt = UILabel(frame: CGRect(x: 5,y: 318, width: fullCard.frame.size.width-10, height: 20))
        whereAt.text =  "\(String(describing: lc[0].place!))"
        whereAt.textAlignment = NSTextAlignment.left
        whereAt.font = UIFont(name:"HelveticaNeue-Bold", size: 18)
        whereAt.textColor = UIColor.black
        
        desc = UITextView(frame: CGRect(x: 5,y: 340, width: fullCard.frame.size.width-10, height: 600))
        print("desc")
        desc.textAlignment = .left
        let descStr = try! NSAttributedString(
            data: (lc[0].desc?.data(using: String.Encoding.unicode, allowLossyConversion: true)!)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        desc.attributedText = descStr
        desc.isEditable = false
        desc.font = UIFont (name: "Helvetica Neue", size: 15)
        desc.isScrollEnabled = false
        desc.textColor = UIColor.black
        desc.backgroundColor = UIColor.clear
        
        cardButton  = UIButton(frame: CGRect(x: 0,y: 0, width: fullCard.frame.size.width, height: fullCard.frame.size.height))
        
        fullCard.addSubview(who)
        fullCard.addSubview(userImage)
        self.view.addSubview(titleLabel)
        fullCard.addSubview(line)
        fullCard.addSubview(when)
        fullCard.addSubview(whereAt)
        fullCard.addSubview(cardButton)
        fullCard.addSubview(headerImage)
        fullCard.addSubview(participantView)
        fullCard.addSubview(desc)
        if(lc[0].status == 0)
        {
            fullCard.contentSize = CGSize(width: fullCard.frame.size.width, height:desc.contentSize.height + 60)
            signupButton.frame = CGRect(x: 0,y: UIScreen.main.bounds.height-50, width: UIScreen.main.bounds.width, height: 50)
            signupButton.alpha = 0.0
            if((User.favoriteLectures[lc[0].day]?.filter{$0.id == lc[0].id && $0.signedUp == true}.count)! == 0)
            {
                signupButton.setTitle("Tilmeld mig", for: .normal)
                signupButton.backgroundColor =  UIColor.infoBlue()
                signupButton.tag = 0
            }
            else
            {
                self.signupButton.tag = 1
                self.signupButton.backgroundColor = .red
                self.signupButton.setTitle("Afmeld mig!", for: .normal)
              
            }
            signupButton.setTitleColor(UIColor.white, for: .normal)
            signupButton.addTarget(self, action: #selector(signup(sender:)), for: UIControlEvents.touchUpInside)
            self.view.addSubview(signupButton)
            
        }
        else
        {
            fullCard.contentSize = CGSize(width: fullCard.frame.size.width, height:desc.contentSize.height + 100)
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
    
    func signup(sender:AnyObject)
    {
        if(sender.tag == 0 || lc[0].signedUp == false)
        {
              print("add")
      
       if(UserController().addToFavoritList(type: "lecture", lecture: lc[0], auctionItem:nil) == true)
       {
         lc[0].signedUp = true
        self.signupButton.tag = 1
        self.signupButton.backgroundColor = .red
        self.signupButton.setTitle("Afmeld mig!", for: .normal)
       }
        }
        else
        {
            print("remove")
            if(UserController().removeFromFavoritList(type: "lecture", lecture: lc[0], auctionItem:nil) == true)
            {
                lc[0].signedUp = false
                self.signupButton.tag = 0
                self.signupButton.backgroundColor = .infoBlue()
                self.signupButton.setTitle("Tilmeld mig!", for: .normal)
            }
        }
    }
    
}
