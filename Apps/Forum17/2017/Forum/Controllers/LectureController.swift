
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
    func loadLectures(test:Bool,completion:@escaping (_ result:[Int:[Lecture]]) -> Void)
    {
        
        var lectures =  [Lecture]()
        Lecture.lectureContainer.removeAll()
        n.getLectures(test: test) { (result) in
            for days in result
            {
                lectures.removeAll()
                for i in days.1["programItems"]
                {
                    let lecture = Lecture(JSONString:JSON(i.1.dictionaryValue).description)!
                    lecture.id = i.0
                    lecture.day = Int(days.0)!
                    lecture.startDate = days.1["date"].stringValue
                    lectures.append(lecture)
                    
                }
                lectures = lectures.sorted{$0.0.startTime! < $0.1.startTime!}
                Lecture.lectureContainer.updateValue(lectures, forKey: Int(days.0)!)
                
            }
                lectures.removeAll()
            completion(Lecture.lectureContainer)
        }
 
        
    }

 
    

    
    //Updates dictonary and updates DB
    func update(lecture:Lecture, row:Int,day:Int, completion:(_ result:Bool) -> Void)
    { 
        
         if(lecture.id != "")
         {
        if(day != lecture.day)
        {
            Lecture.lectureContainer[day]?.remove(at: row)
            Lecture.lectureContainer[lecture.day]?.append(lecture)
         
        }
        else
        {
            Lecture.lectureContainer[day]?[row] = lecture
        }
        }
        else
        {
            Lecture.lectureContainer[day]?.append(lecture)
            
           
        }
       completion(true)
        
    }
    
    func lecturesFromLocalMemory(day:Int, completion:(_ result:[Lecture]) -> Void)
    {
        completion(Lecture.lectureContainer[day]!.sorted{$0.0.startTime! < $0.1.startTime!})
    }
     
}
