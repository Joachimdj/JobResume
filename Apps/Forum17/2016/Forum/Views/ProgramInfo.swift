//
//  ProgramInfo.swift
//  Forum
//
//  Created by Joachim Dittman on 05/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseStorage

class ProgramInfo: UIViewController {

    var fullCard = UIScrollView()
    let buttonView = UIView()
    var SP = programContainer[0]
    let participantView = UIScrollView(frame: CGRect(x: 0,y: 130, width: screenSize.size.width, height: 80))
    override func viewDidLoad() {
        mapButton.alpha = 0.0
        super.viewDidLoad()
        
        if(yourdProgram == false){
         SP = dateContainer[selectedProgram].programObjects[selectedItem]
        }
        else
        {
         SP = favoriteContainer[selectedItem]
        }
        self.view.backgroundColor = UIColor(red: 142.0/255, green: 122.0/255, blue: 183.0/255, alpha: 1.0)
        var title: UILabel!
        var line: UILabel!
        var who: UITextView!
        var when: UILabel!
        var whereAt: UILabel!
        let headerImage = UIImageView()
        var cardButton: UIButton!
        var desc: UITextView!
        
        fullCard.frame = CGRect(x: 0,y: 60, width: screenSize.width, height: screenSize.height-60)
        fullCard.backgroundColor = UIColor.white
        
        let bImage = UIButton()
        bImage.frame = CGRect(x: -10,y: 0,width: 70,height: 70)
        bImage.setImage(UIImage(named: "ic_close")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        bImage.tintColor = UIColor.white
        bImage.addTarget(self, action: #selector(ProgramInfo.close(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(bImage)
        
        
        let bImage1 = UIButton()
        bImage1.frame = CGRect(x: screenWidth-60,y: 0,width: 70,height: 70)
        if(dict1.contains("\(SP.date)\(SP.id)"))
        {
           bImage1.setImage(UIImage(named: "heartDark")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
            
        }
        else
        {
           bImage1.setImage(UIImage(named: "heart")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        }
        
        bImage1.tintColor = UIColor.white
        bImage1.addTarget(self, action: #selector(ProgramInfo.addFavorite(_:)), for:
            UIControlEvents.touchUpInside)
        self.view.addSubview(bImage1)
        
        headerImage.frame = CGRect(x: 0,y: 0,width: screenWidth,height: 165)
       
        let URLHeader = URL(string: SP.headerImage)!
        headerImage.kf.setImage(with: URLHeader, placeholder: UIImage(named: "bifrost"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
            
        })
       
        var start:CGFloat = 0
        var k = 0
        let a = SP.lecturer.count
        let calculateStart = (Int((screenWidth/2)) - (a * 35))
        start = CGFloat(calculateStart)
        var lecturerString = ""
        for i in SP.lecturer {
            
                let image = UIImageView()
                image.frame =  CGRect(x: start,y: 5, width: 60, height: 60)
                let URL = Foundation.URL(string: i.image)!
                image.kf.setImage(with: URL, placeholder: UIImage(named: "bifrost"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
                
                })
                image.layer.borderWidth = 2.0
                image.layer.borderColor = UIColor.lightGray.cgColor
                image.clipsToBounds = true;
                image.layer.cornerRadius = image.frame.width/2;
            
                participantView.addSubview(image)
            if(a == 1){lecturerString += "\(i.name)"} else
            {
            if(k <  a-2){lecturerString += "\(i.name), "}
            else
            {
                if(k <  a-1){lecturerString += "\(i.name) "} else {lecturerString += "& \(i.name)"}
            }
            }
            k += 1
            start += 70
            
        }
        
        title = UILabel(frame: CGRect(x: 20,y: 23, width: fullCard.frame.size.width-40, height: 20))
        title.text = SP.name
        title.textAlignment = NSTextAlignment.center
        title.font = UIFont(name:"HelveticaNeue-Bold", size: 15)
        title.textColor = UIColor.white
        
        line = UILabel(frame: CGRect(x: 5,y: 260, width: fullCard.frame.size.width-10, height: 4))
        
        line.backgroundColor = UIColor.lightGray
        
        
        who = UITextView(frame: CGRect(x: 0,y: 190, width: fullCard.frame.size.width, height: 40))
        who.text =  "\(lecturerString)"
        who.textAlignment = NSTextAlignment.center
        who.font = UIFont(name:"HelveticaNeue", size: 12)
        who.textColor = UIColor.black
        
        when = UILabel(frame: CGRect(x: 5,y: 235, width: fullCard.frame.size.width-10, height: 20))
        when.text =  "\(SP.startTime) - \(SP.endTime)"
        when.textAlignment = NSTextAlignment.left
        when.font = UIFont(name:"HelveticaNeue", size: 20)
        when.textColor = UIColor.black
        
        whereAt = UILabel(frame: CGRect(x: 5,y: 235, width: fullCard.frame.size.width-10, height: 20))
        whereAt.text =  "\(SP.place) "
        whereAt.textAlignment = NSTextAlignment.right
        whereAt.font = UIFont(name:"HelveticaNeue", size: 20)
        whereAt.textColor = UIColor.black
        
        desc = UITextView(frame: CGRect(x: 5,y: 265, width: fullCard.frame.size.width-10, height: 600))
        
        desc.textAlignment = .left
        let attrStr = try! NSAttributedString(
            data: SP.desc.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        desc.attributedText = attrStr
        desc.isEditable = false
        desc.font = UIFont (name: "Helvetica Neue", size: 15)
        desc.isScrollEnabled = false
        desc.textColor = UIColor.black
        desc.backgroundColor = UIColor.clear
        
        cardButton  = UIButton(frame: CGRect(x: 0,y: 0, width: fullCard.frame.size.width, height: fullCard.frame.size.height))
       
        fullCard.addSubview(headerImage)
      
        self.view.addSubview(title)
        fullCard.addSubview(line)
        fullCard.addSubview(who)
        fullCard.addSubview(participantView)
        fullCard.addSubview(when)
        fullCard.addSubview(whereAt)
        fullCard.addSubview(cardButton) 
        fullCard.addSubview(desc)
        
        fullCard.contentSize = CGSize(width: fullCard.frame.size.width, height: desc.contentSize.height)
        
        
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
        mapButton.alpha = 1.0
    }
    func addFavorite(_ sender:AnyObject)
    {
        print("favorite")
        let itemString = "\(SP.date)\(SP.id)"
        if(dict1.contains(itemString))
        {
            var tempDict = [String]()
            for i in dict1
            {
                print(i)
                print(itemString)
                
                if(i != itemString)
                {
                    tempDict.append(i)
                }
                
            }
            dict1.removeAll()
            dict1 = tempDict
            print(dict1)
            
        }
        else
        {
            dict1.append("\(SP.date)\(SP.id)")
            print(dict1)
        }
       
        let defaults = UserDefaults.standard
        defaults.set(dict1, forKey: "SavedArray")
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
