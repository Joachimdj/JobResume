//
//  Lecture.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation
import ObjectMapper




class Lecture: Mappable {
 
    
    static var lectureContainer = [Int:[Lecture]]()
    var id: String = ""
    var name: String? 
    var endTime:String?
    var startTime:String?
    var place: String?
    var type:String?
    var headerImage:String?
    var lecturer:[String:[String:String]]?
    var desc:String?
    var favorit = false
    var day = 0
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) { 
        name    <- map["title"]
        endTime <- map["endTime"]
        startTime <- map["startTime"]
        place <- map["place"]
        type <- map["type"]
        headerImage <- map["headerImage"]
        lecturer <- map["lecturer"]
        desc <- map["description"]
    }
}
    
