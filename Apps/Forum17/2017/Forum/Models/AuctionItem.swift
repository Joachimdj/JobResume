//
//  AuctionItem.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation
import ObjectMapper


class AuctionItem: Mappable {
    
    static var AuctionItemContainer = [AuctionItem]()
   
    
    var id: String?
    var name: String?
    var bidders: [String:[String:Any]]?
    var desc: String?
    var donator: String?
    var donatorImage: String?
    var image: String?
    var donatorWebsite: String?
    var endDate: String?
    var startBid: Double?
    var status: Int?
    var favorit = false
    
    
    
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name    <- map["name"]
        bidders        <- map["bidders"]
        desc      <- map["desc"]
        donator   <- map["donator"]
        donatorImage  <- map["donatorImage"]
        image  <- map["image"]
        donatorWebsite <- map["donatorWebsite"]
        endDate <- map["endDate"]
        startBid <- map["startBid"]
        status <- map["status"]
    }
}
    
