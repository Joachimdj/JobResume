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
        lc.loadLectures(test: true) { (result) in
            XCTAssertEqual(result.count,3)
        } 
    }
 
    
    //Test update and create orders.
    func testUpdate()
    {
        lc.loadLectures(test: true) { (result) in
            print(result.count)
            self.lc.update(lecture: (result[0]?[0])!, row: 0, day: 0) { (result) in
                 XCTAssertTrue(result)
            }
        }
        
     //
    }
    
    //LoadLectures from local memory.
    func testLectureFromLocalMemory()
    {
        lc.loadLectures(test: true) { (result) in
            self.lc.lecturesFromLocalMemory(day: 0) { (result) in
                XCTAssertEqual(result.count, 5)
            }
        }
     
     //   XCTAssertTrue(false)
    }
   
    //Get lecture subscriptions 
    func testGetLectureSubscription()
    {
     //   XCTAssertTrue(false)
    }
    
}
