//
//  AuctionControllerTests.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import Forum

class AuctionControllerTests: XCTestCase {
    
    let ac = AuctionController() 
    
    override func setUp() {
        super.setUp()
      
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Loads auction items from mockup
    func testLoadAuctionItems() {
        XCTAssertEqual(ac.loadAuctionItems().count,25)
    }
    
    //User makes an offer on an auction item.
    func testMakeAnOffer() {
        XCTAssertTrue(ac.makeAnOffer())
    }
  
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
