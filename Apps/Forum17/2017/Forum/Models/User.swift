//
//  User.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation
import ObjectMapper


class User: Mappable {
    
    static var userContainer = [User]() 
    static var favoriteLectures = [Int:[Lecture]]()
    static var favoriteAuctionItems = [AuctionItem]()
    var id: String?
    var name: String?
    var email: String?
    var picture: String!
    
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        id    <- map["id"]
        name    <- map["name"]
        email        <- map["email"]
        picture      <- map["picture"]
    }
    
}
