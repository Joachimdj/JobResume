//
//  Models.swift
//  Forum
//
//  Created by Joachim Dittman on 04/08/2016.
//  Copyright © 2016 Joachim Dittman. All rights reserved.
//


class ProgramObject {
    let id : String
    let name : String
    let date : String
    let headerImage: String
    let lecturer : [lectureObject]
    let startTime : String
    let endTime : String
    let desc : String
    let place : String
    let type : Int
    
    
    
    init(id : String, name:String, date:String,headerImage:String,lecturer: [lectureObject],startTime:String,endTime:String,desc:String,place:String,type:Int)
    {
        self.id = id
        self.name = name
        self.date = date
        self.headerImage = headerImage
        self.lecturer = lecturer
        self.startTime = startTime
        self.endTime = endTime
        self.desc = desc
        self.place = place
        self.type = type
    }
}

class lectureObject {
    let id : String
    let name : String
    let image :  String
    
    
    
    init(id : String, name:String,image: String)
    {
        self.id = id
        self.name = name
        self.image = image
    }
}
class dateObject {
    let id : String
    let name : String
    let programObjects : [ProgramObject]
    
    
    
    init(id : String, name:String,programObjects:[ProgramObject])
    {
        self.id = id
        self.name = name
        self.programObjects = programObjects
    }
}


class auctionObject {
    let id : String
    let name : String
    let desc : String
    let donator : String
    let donatorImage : String
    let donatorWebsite : String
    let endDate : String
    let image : String
    let bidder : String
    let bid : Int
    let phone : String
    let createdAt : Int
    
    
    
    init(id : String, name:String, desc:String, donator:String, donatorImage:String,donatorWebsite:String,endDate:String, image:String, bidder:String, bid:Int, phone:String,createdAt: Int)
    {
        self.id = id
        self.name = name
        self.desc = desc
        self.donator = donator
        self.donatorImage = donatorImage
        self.donatorWebsite = donatorWebsite
        self.endDate = endDate
        self.image = image
        self.bidder = bidder
        self.bid = bid
        self.phone = phone
        self.createdAt = createdAt
    }
}

 