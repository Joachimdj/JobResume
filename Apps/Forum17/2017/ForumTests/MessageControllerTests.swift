//
//  MessageControllerTests.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import XCTest
@testable import Forum


class MessageControllerTests: XCTestCase {
    
    let mc = MessageController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
   
    //Tests if a lecture admin can sent a push message to participants.
    func testSendMessage() {
      XCTAssertTrue( mc.sendMessage(id: "", type: "", topic: "topic", message: ""))
    }
    
    //Runs in background of app and checks if theire are any upcoming lectures or auction items.
    func testUpcomingLectures() {
       mc.upcomingLectures(reciver: "", completion: { (result) in
             XCTAssertFalse(result)
        })
        
       
    }
    
    func testSubscripeToTopic()
    {
        XCTAssertTrue(mc.subscripeToTopic(topic: "forum"))
    }
    
    func testUnSubscripeToTopic()
    {
        XCTAssertTrue(mc.unsubscripeToTopic(topic: "forum"))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
