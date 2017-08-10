//
//  Network.swift
//  Forum
//
//  Created by Joachim Dittman on 30/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON

func loadAuctionItems()
{
    
     DispatchQueue.global(qos: .userInitiated).async {// 1
        let ref = FIRDatabase.database().reference()
        ref.child("auction").observe(FIRDataEventType.value, with: { (snapshot) in
            
            let dataString = JSON(snapshot.value!)
            //  print(dataString)
            
            auctionContainer.removeAll()
            for i in dataString
            {
                if(i.1["status"].intValue != 3){
                    print(i.1["name"].stringValue)
                    auctionContainer.append(auctionObject(id: i.0, name: i.1["name"].stringValue, desc: i.1["desc"].stringValue, donator: i.1["donator"].stringValue, donatorImage: i.1["donatorImage"].stringValue, donatorWebsite: i.1["donatorWebsite"].stringValue, endDate: i.1["endDate"].stringValue, image: i.1["image"].stringValue, bidder: i.1["bidder"].stringValue, bid: i.1["startBid"].intValue, phone: i.1["phone"].stringValue, createdAt: i.1["createdAt"].intValue))
                }
                
                
            }
            auctionContainer.sort{$0.0.createdAt < $0.1.createdAt}
         
            
        })
        DispatchQueue.main.async { // 2
           NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadTable"), object: nil)
        }
    }

}
