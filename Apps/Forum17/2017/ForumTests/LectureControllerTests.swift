//
//  LectureControllerTests.swift
//  Forum
//
//  Created by Joachim Dittman on 13/08/2017.
//  Copyright © 2017 Joachim Dittman. All rights reserved.
//

import XCTest

@testable import Forum

class LectureControllerTests: XCTestCase {
    
    let lc = LectureController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Loads auction items from mockup
    func testLoadLectures() {
      
        XCTAssertEqual(lc.loadLectures().count, 3)
    }
    
    //User makes an offer on an auction item.
    func testSignup() {
        
         XCTAssertTrue(lc.signup(lecture: ""))
    }
   
}
