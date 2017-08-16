//
//  AuctionController.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation
import SwiftyJSON

class AuctionController
{ 
  
    let n  = Network()
    let a  = AuctionItem.self
    
    //Loads auction items from mockup
    func loadAuctionItems() -> [AuctionItem]
    {
        n.getAuctionItems{ (result) in
            a.AuctionItemContainer.removeAll()
            for i in result
            {
                let auction = AuctionItem(JSONString:JSON(i.1.dictionaryValue).description)!
                auction.id = i.0
                a.AuctionItemContainer.append(auction)
            }
        } 
        return a.AuctionItemContainer
    }
    
    //User makes an offer on an auction item.
    func makeAnOffer() -> Bool
    {
        return true
    }
   
}
