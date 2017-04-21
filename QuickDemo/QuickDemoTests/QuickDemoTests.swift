//
//  QuickDemoTests.swift
//  QuickDemoTests
//
//  Created by YorrickBao on 2017/4/21.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import XCTest
import RainbowSwift
import Quick
@testable import QuickDemo

class QuickDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        XCTAssertTrue(false, "hello test".red)
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
