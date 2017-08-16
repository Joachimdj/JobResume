//
//  AuctionListCell.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import UIKit

class AuctionListCell: UITableViewCell {

    let cellView = UIView(frame: CGRect(x: 10, y: 5, width: UIScreen.main.bounds.width - 20, height: 100))
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 100))
    let favorite = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 65, y: 0, width: 50 , height: 100))
    let startBid = UILabel(frame: CGRect(x:135,y: 50,width: UIScreen.main.bounds.width-160,height: 25))
    let titleLabel = UITextView(frame: CGRect(x: 135,y: 0,width:UIScreen.main.bounds.width-145,height: 50))
    let donator = UILabel(frame: CGRect(x:135,y: 75,width:UIScreen.main.bounds.width-160,height: 25))
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellView.backgroundColor = .white
        cellView.dropShadow()
        
        donator.textAlignment = .left
        donator.font = UIFont (name: "HelveticaNeue", size: 10)
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
        titleLabel.isUserInteractionEnabled = false
        
        titleLabel.font = UIFont (name: "HelveticaNeue-bold", size: 12)
        startBid.textAlignment = .left
        startBid.font = UIFont (name: "HelveticaNeue", size: 11)
        
        profileImageView.layer.borderWidth = 0.0
        profileImageView.layer.borderColor = UIColor.white.cgColor;
        profileImageView.image = UIImage(named: "logo")
        profileImageView.clipsToBounds  = true
        favorite.setImage(UIImage(named: "heart"), for: UIControlState())
        cellView.addSubview(donator)
        cellView.addSubview(titleLabel)
        cellView.addSubview(startBid)
        cellView.addSubview(profileImageView)
        cellView.addSubview(favorite)
        
        self.contentView.addSubview(cellView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
extension UIView {
    
    func dropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: -0.5, height: 1)
        self.layer.shadowRadius = 2
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
}
