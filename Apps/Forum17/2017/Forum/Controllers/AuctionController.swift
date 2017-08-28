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
    func loadAuctionItems(completion:@escaping ([AuctionItem]) -> Void)
    {
        n.getAuctionItems(test: false){ (result) in
            self.a.AuctionItemContainer.removeAll()
            for i in result
            {
                 
                let auction = AuctionItem(JSONString:JSON(i.1.dictionaryValue).description)!
                auction.id = i.0
                self.a.AuctionItemContainer.append(auction)
            }
            completion(self.a.AuctionItemContainer)
        } 
 
    }
    
    //User makes an offer on an auction item.
    func makeAnOffer(auction:AuctionItem,bid:Double,row:Int) -> Bool
    {
        let user = UserController()
        auction.bidders = [user.tempUserId:["name":user.tempUserName,"token":user.tempUserToken,"offer":bid]]
        AuctionItem.AuctionItemContainer[row] = auction
        return true
    }
    
    //Updates dictonary and updates DB
    func update(auction:AuctionItem, row:Int, completion:(_ result:Bool) -> Void)
    {
        if(auction.id != "")
        {
            AuctionItem.AuctionItemContainer[row] = auction
            completion(true)
        }
        else
        {
            let startCount = AuctionItem.AuctionItemContainer.count
            
             AuctionItem.AuctionItemContainer.append(auction)
            if(startCount < AuctionItem.AuctionItemContainer.count)
            {
                completion(true)
            }
            else
            {
                completion(false)
            }
        }
    }
    
    
}
