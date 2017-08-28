//
//  UserControllerTests.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import XCTest

@testable import Forum

class UserControllerTests: XCTestCase {
    
 
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
 
    func testLoadFavorites()
    {
    /*   let uc = UserController()
       uc.getFavoriteAuctionItems(test: true) { (result) in
            XCTAssertFalse(result)
        }
        
       uc.getFavoriteLectures(test: true) { (result) in
        XCTAssertFalse(result)
        }
 */
    }
 
    //Create user with providor
    func testCreateUser()
    {
   //     XCTAssertTrue(uc.createUser())
    }
    
    //Check users login status
    func testCheckUsersLoginStatus()
    {    
    }
    
    //Add to FavoritList
    func testAddToFavoritList()
    {     let uc = UserController()
        XCTAssertFalse(uc.addToFavoritList(type: "lectured", lecture: nil, auctionItem: nil))
        
        
    }
    
    
    //Remove from FavoritList
    func testRemoveFromFavoritList()
    {   // let uc = UserController()
        //XCTAssertFalse(uc.addToFavoritList(type: "auction", lecture: nil, auctionItem:nil))
         
    }
    
    
}
