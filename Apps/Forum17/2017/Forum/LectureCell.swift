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

class LectureCell: UITableViewCell {
    
    
    let cellView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70))
    let typeImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 70 , height: 70))
    let favorite = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 60, y: 0, width: 70 , height: 70))
    let titleLabel = UITextView(frame: CGRect(x: 80,y: 0,width: UIScreen.main.bounds.width-80 ,height: 50))
    let placeLabel = UILabel(frame: CGRect(x: 80,y: 40,width: UIScreen.main.bounds.width-80,height: 25))
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellView.backgroundColor = .white
        cellView.dropShadow()
        titleLabel.isUserInteractionEnabled = false
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 14)
        placeLabel.textAlignment = .left
        placeLabel.font = UIFont (name: "Helvetica Neue", size: 13)
        
        typeImage.layer.cornerRadius =  typeImage.frame.size.width / 2
        typeImage.layer.borderWidth = 3.0
        typeImage.layer.borderColor = UIColor.white.cgColor;
        typeImage.image = UIImage(named: "logo")
        typeImage.clipsToBounds  = true
        favorite.setImage(UIImage(named: "heart"), for: UIControlState())
 
        cellView.addSubview(titleLabel)
        cellView.addSubview(placeLabel)
        cellView.addSubview(typeImage)
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
