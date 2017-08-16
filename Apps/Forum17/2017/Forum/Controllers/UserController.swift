//
//  UserController.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation

class UserController
{
     let tempUserId = "28c92kd901kds9f9sdf91kd"
     let uc = User.self
     let lc = LectureController()
     let n = Network()
    //Create user with providor
    func createUser() -> Bool
    {
     
        return true
    }
    
    //Get favorite lectures.
    func getFavoriteLectures() -> [Int:[Lecture]]
    {
 
        n.getFavorites(type:"lectures", user: tempUserId) { (result) in
            var favoritesLecturesContainer = [Int:[Lecture]]() 
            var lectureDic = [String:Lecture]()
            for ll in Lecture.lectureContainer
            {
                for lec in ll.value
                {
                    let id:String = lec.id
                    lectureDic.updateValue(lec, forKey: id)
                    print(lectureDic.count)
                }
                var lectures = [Lecture]()
                for i in result
                {
                    if(lectureDic[i.0] != nil)
                    { 
                        lectures.append(lectureDic[i.0]!)
                    }
                    
                }
                favoritesLecturesContainer.updateValue(lectures, forKey: ll.key)
                lectureDic.removeAll()
            }
            self.uc.favoriteLectures = favoritesLecturesContainer
        }
        print("lectures\(uc.favoriteLectures.count)")
        for i in uc.favoriteLectures
        {
            print(i.key)
            for k in i.value
            {
                print(k.id)
            }
        }
        return uc.favoriteLectures
    }
    
    //Get favorite lectures.
    func getFavoriteAuctionItems() -> [AuctionItem]
    {
        n.getFavorites(type:"auction", user: tempUserId) { (result) in
            print(result)
            var items = [AuctionItem]()
            for i in result
            {
                print(i.0)
                let item = AuctionController().a.AuctionItemContainer.filter{$0.id == i.0}
                if(item.count > 0)
                {
                    items.append(item[0])
                }
               
            }
          
            self.uc.favoriteAuctionItems = items
        }
        return uc.favoriteAuctionItems
    }
    
    //Check users login status
    func checkUsersLoginStatus() -> Bool
    {
        
         return true
    }
    
    //Add to FavoritList
    func addToFavoritList(type:String,lecture:Lecture?,auctionItem:AuctionItem?) -> Bool
    {
        
        if(type == "lecture")
        {
            var returnState = true
            for days in Lecture.lectureContainer
            {
                for i in days.value
                {
                    if(i.id == lecture?.id)
                    {
                        returnState = true
                        User.favoriteLectures[days.key]?.append((lecture)!)
                    }
                }
            }
            
            return returnState
        }
        if(type == "auction")
        {
            if(User.favoriteAuctionItems.filter{$0.id == auctionItem?.id}.count == 0)
            {
             User.favoriteAuctionItems.append(auctionItem!)
                return true
            }
            else
            {
                return false
            }
            
        }
        else
        {
            return false
        }
    }
    
    
    //Remove from FavoritList
    func removeFromFavoritList(type:String,lecture:Lecture?,auctionItem:AuctionItem?)  -> Bool
    { 
        if(type == "lecture")
        {
             var returnState = false
             var removed = 0
            
            for day in uc.favoriteLectures
            {
                
                let afterFilter = User.favoriteLectures[day.key]?.filter{$0.id != lecture?.id}
                removed = (User.favoriteLectures[day.key]?.count)! - (afterFilter?.count)!
                User.favoriteLectures[day.key] = afterFilter
                if(removed > 0)
                {
                    returnState = true
                }
                
            }
            return returnState
        }
        if(type == "auction")
        {
                 User.favoriteAuctionItems = User.favoriteAuctionItems.filter{$0.id != auctionItem?.id}
                 return true
        }
        else
        {
            return false
        }
    }
    
    
    
}
