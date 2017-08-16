//
//  Network.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation
import SwiftyJSON

class Network
{
  
    func loadFromFile(completion:(_ result:JSON) -> Void)
    {
        if let path = Bundle.main.path(forResource: "testDb", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    completion(jsonObj)
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
         
    }
    
    func getLectures(completion:(_ result:JSON) -> Void)
    {
        loadFromFile { (result) in 
            completion(result["eventDates"])
        }
        
    }
    
    
    func getAuctionItems(completion:(_ result:JSON) -> Void)
    {
        loadFromFile { (result) in
            completion(result["auction"])
        }
    }
    
    func getFavorites(type:String,user:String,completion:@escaping (_ result:JSON) -> Void)
    {
        loadFromFile { (result) in 
            completion(result["favorites"][user][type])
        }
    }
    
    
    func setfavoriteCount(user:String,lecture:String,auctionItem:String,completion:(_ result:JSON) -> Void)
    {
        
        completion(JSON(""))
    }
    
    func setfavoriteCount(user:String,lecture:String,auctionItem:String,completion:(_ result:Bool) -> Void)
    {
        
        completion(true)
    }
    
    
    func updateAuctionItemOffer(user:String,auctionItem:String,offer:Double, completion:(_ result:Bool) -> Void)
    {
        
        completion(true)
    }
    
    func updateAuctionItem(user:String,auctionItem:String, completion:(_ result:Bool) -> Void)
    {
        
        completion(true)
    }
    
    func updateLecture(user:String,auctionItem:String, completion:(_ result:Bool) -> Void)
    {
        
        completion(true)
    }
    
    func userLogin(token:String,providor:String, completion:(_ result:JSON) -> Void)
    {
        
         completion(JSON(""))
    }
    
    func getMap(completion:(_ result:JSON) -> Void)
    {
        
         completion(JSON(""))
    }
    
    
    
}
