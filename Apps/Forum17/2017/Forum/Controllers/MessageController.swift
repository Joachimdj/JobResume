//
//  MessageController.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import FirebaseMessaging

class MessageController
{
    
    //Lecture admins can sent a push message to participants.
    func sendMessage(id:String,type:String,topic:String,message:String) -> Bool
    {
        let key = "AAAABKPvIWk:APA91bGhnrtein4VFnn7VafMqBlQangZXfupMyFf20PttXdNsJgKo_ecW5Ex2ryqPd-Tm6kepiT_lOAGMMsBuZ5OV2hzFjqPYn67dFEBltIxFBG_w69kMlHoRVSxVjxqmT1jKKdOhYf9"
        
        let parameters: Parameters = [
            "to": "/topics/\(topic)",
            "priority": "high",
            "sound": "default",
            "badge": 1,
            "title":"Info",
            "content_available": true,
            "notification": ["body": message,"title":"Info","badge": 1,"sound": "default"],
            "data":["title":"Info","body": message]
            ] as [String : Any]
        
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Authorization": "key=\(key)"
            
        ]
        print(parameters)
        print(headers)
        Alamofire.request("https://fcm.googleapis.com/fcm/send", method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: headers).responseJSON { response in 
            switch response.result {
            case .success:
                print("Validation Successful")
                print(response.value!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return true
    }
    
    
    func subscripeToTopic(topic:String) -> Bool
    {
        Messaging.messaging().subscribe(toTopic: topic)
        return true
    }
    
    func unsubscripeToTopic(topic:String) -> Bool
    {
        Messaging.messaging().unsubscribe(fromTopic: topic)
         return true
    }
    
    
    //Runs in background of app and checks if theire are any upcoming lectures or auction items.
    func upcomingLectures(reciver:String, completion:@escaping (_ result:Bool) -> Void)
    {
        print("upcoming lectures")
        let fl = User.favoriteLectures
        if(fl.count == 0 || reciver == "")
        {
            completion(false)
        }
        else
        {
            let key = "AAAABKPvIWk:APA91bGhnrtein4VFnn7VafMqBlQangZXfupMyFf20PttXdNsJgKo_ecW5Ex2ryqPd-Tm6kepiT_lOAGMMsBuZ5OV2hzFjqPYn67dFEBltIxFBG_w69kMlHoRVSxVjxqmT1jKKdOhYf9"
            var message = ""
            var count = 0
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
        for i in fl
            {
                for d in i.value
                {
              
                    let date:String = d.startDate
                    let time:String = d.startTime!
                
                   let lectureDate = dateFormatter.date(from: "\(date) \(time)")
                    print(lectureDate!)
                    print(Date())
                    let minute:TimeInterval = 1200.0
                    print(Date(timeIntervalSinceNow: minute))
                    if(Date(timeIntervalSinceNow: minute) > lectureDate!  && Date() < lectureDate!)
                   {
                    message.append("'\(d.name!)'")
                    if( count > 0)
                    {
                        message.append(", ")
                    }
                    count += 1
                   }
                }
            }
      
        
        if(count > 0)
        {
           message.append(" starter om under 10 minutter.")
        
            let parameters: Parameters = [
                "to": reciver,
                "priority": "high",
                "sound": "default",
                "badge": 1,
                "title":"Info",
                "content_available": true,
                "notification": ["body":message,"badge": 1,"sound": "default"],
                "data":["body": message]
                ] as [String : Any]
            
            let headers = [
                "Content-Type": "application/json",
                "Cache-Control": "no-cache",
                "Authorization": "key=\(key)"
                
            ]
            print(parameters)
            print(headers)
            Alamofire.request("https://fcm.googleapis.com/fcm/send", method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success:
                    completion(true)
                    print("Validation Successful")
                    print(response.value!)
                case .failure(let error):
                     completion(false)
                    print(error.localizedDescription)
                }
            }
            }
            else
            {
            completion(false)
            }
        }
        
        }
 
    
}
