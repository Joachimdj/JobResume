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
    
    let lc = LectureController()
    let ac = AuctionController()
    let uc = UserController()
    let n  = Network()
    
    override func setUp() {
        super.setUp()
        n.loadFromFile { (result) in
          _ =  lc.loadLectures()
          _ =  ac.loadAuctionItems()
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
 
    func testLoadFavorites()
    {
        XCTAssertEqual(uc.getFavoriteAuctionItems().count,1)
        XCTAssertEqual(uc.getFavoriteLectures().count,3)
    }
 
    //Create user with providor
    func testCreateUser()
    {
        XCTAssertTrue(uc.createUser())
    }
    
    //Check users login status
    func testCheckUsersLoginStatus()
    {
         XCTAssertTrue(uc.checkUsersLoginStatus())
    }
    
    //Add to FavoritList
    func testAddToFavoritList()
    {
        XCTAssertFalse(uc.addToFavoritList(type: "lectured", lecture: nil, auctionItem: nil))
        
        XCTAssertTrue(uc.addToFavoritList(type: "lecture", lecture: lc.loadLectures()[0]?[0], auctionItem: nil))
        XCTAssertTrue(uc.addToFavoritList(type: "auction", lecture: nil, auctionItem: ac.a.AuctionItemContainer[0]))
 
        
    }
    
    
    //Remove from FavoritList
    func testRemoveFromFavoritList()
    {
        XCTAssertTrue(uc.addToFavoritList(type: "lecture", lecture: lc.loadLectures()[0]?[0], auctionItem: nil))
        XCTAssertTrue(uc.addToFavoritList(type: "auction", lecture: nil, auctionItem: ac.a.AuctionItemContainer[0]))
        
        XCTAssertFalse(uc.removeFromFavoritList(type: "lectured", lecture: nil, auctionItem: nil))
         XCTAssertTrue(uc.removeFromFavoritList(type: "lecture", lecture: lc.loadLectures()[0]?[0], auctionItem: nil))
        XCTAssertFalse(uc.removeFromFavoritList(type: "lecture", lecture: lc.loadLectures()[0]?[0], auctionItem: nil))
         XCTAssertTrue(uc.removeFromFavoritList(type: "auction", lecture: nil, auctionItem: ac.a.AuctionItemContainer[0]))
    }
    
    
}
