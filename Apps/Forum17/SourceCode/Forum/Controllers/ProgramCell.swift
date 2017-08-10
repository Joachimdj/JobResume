//
//  ProgramCell.swift
//  Forum
//
//  Created by Joachim Dittman on 04/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

//
//  NFCell.swift
//  Fritid
//
//  Created by Joachim Dittman on 20/12/2015.
//  Copyright © 2015 Joachim Dittman. All rights reserved.
//


import UIKit

class ProgramCell: UITableViewCell {
    
    
    
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70 , height: 70))
    let favorite = UIButton(frame: CGRect(x: screenWidth - 80, y: 0, width: 70 , height: 70))
    let userName = UILabel(frame: CGRect(x: 80,y: 20,width: screenWidth-80 ,height: 25))
    let firstMessage = UILabel(frame: CGRect(x: 80,y: 0,width: screenWidth-80 ,height: 25))
    let secondMessage = UILabel(frame: CGRect(x: 80,y: 40,width: screenWidth-80,height: 25))
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userName.textAlignment = .left
        userName.font = UIFont (name: "HelveticaNeue", size: 12)
        firstMessage.textAlignment = .left
        firstMessage.font = UIFont (name: "HelveticaNeue-Bold", size: 14)
        secondMessage.textAlignment = .left
        secondMessage.font = UIFont (name: "Helvetica Neue", size: 12)
        
        profileImageView.layer.cornerRadius =  profileImageView.frame.size.width / 2
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.borderColor = UIColor.white.cgColor;
        profileImageView.image = UIImage(named: "logo")
        profileImageView.clipsToBounds  = true
        favorite.setImage(UIImage(named: "heart"), for: UIControlState())
        self.contentView.addSubview(userName)
        self.contentView.addSubview(firstMessage)
        self.contentView.addSubview(secondMessage)
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(favorite)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
}
