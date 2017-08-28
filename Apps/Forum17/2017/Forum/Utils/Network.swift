//
//  Network.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase
import FirebaseDatabase
import FirebaseAuth

class Network
{
    
    var ref: DatabaseReference!
    
   
    
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
  
    func getMapURL(test:Bool,completion:@escaping (_ result:JSON) -> Void)
    {
        if(test == false)
        {
            ref = Database.database().reference()
            
            ref.child("mapUrl").observe(.value, with: { (snap) in
                
                completion(JSON(snap.value!))
            }) { (error) in
                print(error)
            }
        }
        else
        {
            loadFromFile { (result) in
                completion(result["eventDates"])
            }
        }
    }
    
    
    func getLectures(test:Bool,completion:@escaping (_ result:JSON) -> Void)
    {
        if(test == false)
        {
            ref = Database.database().reference()
            
            ref.child("eventDates").observe(.value, with: { (snap) in
               
                completion(JSON(snap.value!))
            }) { (error) in
                print(error)
            }
        }
        else
        {
        loadFromFile { (result) in
            completion(result["eventDates"])
        }
        }
    }
    
    
    func getAuctionItems(test:Bool,completion:@escaping (_ result:JSON) -> Void)
    {
        if(test == false)
        {
            ref = Database.database().reference()
            
            ref.child("auction").observe(.value, with: { (snap) in
              
                completion(JSON(snap.value!))
            }) { (error) in
                print(error)
            }
        }
        else
        {
            loadFromFile { (result) in
                completion(result["auction"])
            }
        }
    }
    
    func getUserFavorites(type:String,user:String,test:Bool,completion:@escaping (_ result:JSON) -> Void)
    {
        if(test == false)
        {
            ref = Database.database().reference()
            
            ref.child("users/\(user)/\(type)").observe(.value, with: { (snap) in
                completion(JSON(snap.value!))
            }) { (error) in
                print(error)
            }
        }
        else
        {
            loadFromFile { (result) in
                completion(result["users"][user][type])
            }
        }
    }
  
 
    func addFavorite(user:String,id:String,type:String,test:Bool, completion:(_ result:Bool) -> Void)
    {
        ref = Database.database().reference()
        ref.child("users/\(user)/\(type)/\(id)").updateChildValues(["type" :"LIKED"])
        completion(true)
    }
    
    func removeFavorite(user:String,id:String,type:String,test:Bool, completion:(_ result:Bool) -> Void)
    {
        ref = Database.database().reference()
        ref.child("users/\(user)/\(type)/\(id)").removeValue()
        completion(true)
    }
    
    
    func updateUser(userData:[String:Any], id:String, test:Bool,completion:@escaping (_ result:Bool) -> Void)
    {   ref = Database.database().reference()
        print("updateUSer \(id) \(userData)")
        ref.child("users/\(id)/info").updateChildValues(userData)
        completion(true)
    }
    
    func checkUserStatus(test:Bool,completion:@escaping (_ result:JSON) -> Void)
    {
        if(Auth.auth().currentUser != nil)
        {
            ref = Database.database().reference() 
            ref.child("users/\(Auth.auth().currentUser!.uid)/info").observe(.value, with: { (snap) in
 
                completion(JSON(snap.value!))
            }) { (error) in
                print(error)
            }
        }
        else
        {
            completion(JSON(""))
        }
    }
    
    
}
