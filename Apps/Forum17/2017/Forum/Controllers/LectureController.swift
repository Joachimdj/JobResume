
//
//  LectureController.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation
import SwiftyJSON

class LectureController
{ 
    var n = Network()

    //Loads lectures from db
    func loadLectures() -> [Int:[Lecture]]
    {
        var lectures =  [Lecture]()
        Lecture.lectureContainer.removeAll()
        n.getLectures { (result) in
            for days in result
            {
                lectures.removeAll()
                for i in days.1["programItems"]
                {
                    let lecture = Lecture(JSONString:JSON(i.1.dictionaryValue).description)!
                    lecture.id = i.0
                    lectures.append(lecture)
                    
                }
                lectures = lectures.sorted{$0.0.startTime! < $0.1.startTime!}
                Lecture.lectureContainer.updateValue(lectures, forKey: Int(days.0)!)
                print("Day:\(Int(days.0)!)")
            }
                lectures.removeAll() 
        } 
        return Lecture.lectureContainer
        
    }

 
    
    //User makes an offer on an lecture item.
    func signup(lecture:String) -> Bool
    {
        return true
    }
     
    
}
