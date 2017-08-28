//
//  UserController.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseInstanceID
import FBSDKLoginKit
import SwiftyJSON
import GoogleSignIn

class UserController
{
    let tempUserId = "28c92kd901kds9f9sdf91kd"
    let tempUserToken = "2sdf9sd9fskdfskdfisdfosd0f9sdfosdf"
    let tempUserName = "Joachim Dittman"
    let uc = User.self
    let lc = LectureController()
    let n = Network()
  
    
    //Get favorite lectures.
    func getFavoriteLectures(test:Bool,completion:@escaping (_ result:Bool) -> Void)
    {
        if(User.userContainer.count == 0)
        {
            completion(false)
        }
        else
        {
        n.getUserFavorites(type:"lectures", user:  User.userContainer[0].id!,test:test) { (result) in
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
            completion(true)
        }
        }
    }
    
    //Get favorite lectures.
    func getFavoriteAuctionItems(test:Bool,completion:@escaping (_ result:Bool) -> Void)
    {
        if(User.userContainer.count == 0)
        {
            completion(false)
        }
        else
        {
        n.getUserFavorites(type:"auctionItems", user: User.userContainer[0].id!,test:test) { (result) in
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
            completion(true)
        }
        }
    }
    
    //Check users login status
    func checkUsersLoginStatus(test:Bool,completion: @escaping (_ result: Bool) -> Void)
    {
        Network().checkUserStatus(test: test) { (result) in
            if(result != "")
            {
                var user = [String:Any]()
                user["id"] = Auth.auth().currentUser!.uid
                user["name"] = result["name"].stringValue
                user["email"] = result["email"].stringValue
                user["picture"] = result["picture"].stringValue
                user["admin"] = result["admin"].intValue
                print(user)
                print("add user")
                let newUser = User(JSON: user)!
                print(newUser.email!)
                var container = [User]()
                container.append(newUser)
                self.uc.userContainer = container
                print(container.count)
                print(self.uc.userContainer.count)
                 completion(true)
            }
            else
            {
                 completion(false)
            }
           
        }
    }
    
    
    
    //Add to FavoritList
    func addToFavoritList(type:String,lecture:Lecture?,auctionItem:AuctionItem?) -> Bool
    {
        if(User.userContainer.count == 0)
        {
            return false
        }
        else
        {
        let user = User.userContainer[0]
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
            let id: String = (lecture?.id)!
            MessageController().subscripeToTopic(topic: "lecture-likes-\(id)")
           
            Network().addFavorite(user: user.id!, id: (lecture?.id)!, type: "lectures", test: false, completion: { (result) in
                
            })
            return returnState
        }
        if(type == "auction")
        {
            if(User.favoriteAuctionItems.filter{$0.id == auctionItem?.id}.count == 0)
            {
                User.favoriteAuctionItems.append(auctionItem!)
                let id: String = (auctionItem?.id)!
                MessageController().subscripeToTopic(topic: "auction-likes-\(id)")
                Network().addFavorite(user: user.id!, id: id, type: "auctionItems", test: false, completion: { (result) in
                    
                })
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
    }

    
    
    func logOut(completion: @escaping (_ result: Bool) -> Void)
    {
        do {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            if(Auth.auth().currentUser != nil)
            {
                print("loggedIn")
                completion(false)
            }
            else
            {
                uc.userContainer.removeAll()
                print("loggedOut")
                completion(true)
            }
          
        }
    }
    
    
    //Remove from FavoritList
    func removeFromFavoritList(type:String,lecture:Lecture?,auctionItem:AuctionItem?)  -> Bool
    {
         if(User.userContainer.count == 0){return false}
        let user = User.userContainer[0]
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
            print("returnState \(returnState)")
            let id: String = (lecture?.id)!
            MessageController().unsubscripeToTopic(topic: "lecture-likes-\(id)")
            Network().removeFavorite(user: user.id!, id: (lecture?.id)!, type: "lectures", test: false, completion: { (result) in
                
            })
            return returnState
        }
        if(type == "auction")
        {
            User.favoriteAuctionItems = User.favoriteAuctionItems.filter{$0.id != auctionItem?.id}
            
            let id: String = (auctionItem?.id)!
            MessageController().unsubscripeToTopic(topic: "auction-likes-\(id)")
            Network().removeFavorite(user: user.id!, id: id, type: "auctionItems", test: false, completion: { (result) in
                
            })
            return true
        }
        else
        {
            return false
        }
    }
    
    
    //Link account with provider
    func linkWithProvider(provider:String,fbResult:String,completion: @escaping (_ result:Bool) -> Void)
    {
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().currentUser?.link(with: credential, completion: { (user, error) in
            if(error == nil)
            {
                completion(true)
            }
            else
            {
                completion(false)
            }
        })
    }
    
    func loginWithNoUser(completion: @escaping (_ result:JSON) -> Void)
    {
        Auth.auth().signInAnonymously() { (user, error) in
            print(user)
       
            let data = ["name":"No name","email":"no email","provider":"Anonymously","picture":""] as [String : Any]
            print(data)
            print(user?.uid)
            if(user?.uid != "")
            {
                Network().updateUser(userData: data, id: (user?.uid)!, test: false, completion: { (result) in
                    
                    completion(JSON(["message":""]))
                })
                
            }
        }
    }
    
    //Login function for email and password.
    func loginWithFacebook(fbToken:String,fbResult:Any?,missingInfo:[String:String],completion: @escaping (_ result:JSON) -> Void)
    {
            let credential = FacebookAuthProvider.credential(withAccessToken: fbToken)
            print(credential)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if(error == nil)
                {
                    let fbInfo = JSON(fbResult)
                    
               
                    // UI Updates
                    let data = ["name":fbInfo["name"].stringValue,"email":fbInfo["email"].stringValue,"provider":"facebook","picture":fbInfo["picture"]["data"]["url"].stringValue] as [String : Any]
                    print(data)
                    print(fbInfo["picture"]["data"]["url"].stringValue)
                    print(user?.uid)
                    if(user?.uid != "")
                    { 
                        Network().updateUser(userData: data, id: (user?.uid)!, test: false, completion: { (result) in
                              completion(JSON(["message":""]))
                        })
                     
                    }
                }
                else
                {  print("SignInError\(error.debugDescription)")
                    if(error?.localizedDescription.contains("already"))!
                    {
                        self.uc.userContainer.removeAll()
                        completion(JSON(["message": "emailExists"]))
                    }
                    else
                    {
                        self.uc.userContainer.removeAll()
                        completion(JSON(["message":"No login"]))
                    }
                }
            })
    }


    //Login function for Google.
    func loginWithGoogle(token:String,accessToken:String,profile:GIDProfileData,completion: @escaping (_ result:JSON) -> Void)
    {
         let credential = GoogleAuthProvider.credential(withIDToken: token, accessToken: accessToken)
        print(credential)
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if(error == nil)
            {
                
                // UI Updates
                let data = ["name":profile.name,"email":profile.email,"provider":"Google","picture":""] as [String : Any]
                print(data)
                if(user?.uid != "")
                { 
                    Network().updateUser(userData: data, id: (user?.uid)!, test: false, completion: { (result) in
                        completion(JSON(["message":""]))
                    })
                    
                }
            }
            else
            {  print("SignInError\(error.debugDescription)")
                if(error?.localizedDescription.contains("already"))!
                {
                    self.uc.userContainer.removeAll()
                    completion(JSON(["message": "emailExists"]))
                }
                else
                {
                    self.uc.userContainer.removeAll()
                    completion(JSON(["message":"No login"]))
                }
            }
        })
    }
}
