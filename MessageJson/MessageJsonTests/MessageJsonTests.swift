//
//  MessageJsonTests.swift
//  MessageJsonTests
//
//  Created by Pengfei Chen on 16/6/29.
//  Copyright © 2016年 Zhen. All rights reserved.
//

import XCTest
@testable import MessageJson

class MessageJsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testsortArray1(){
        let array1 = ViewController.sortArray([8,6,0,9])
        for i in 0 ..< (array1.count - 1){
            XCTAssertTrue(array1[i + 1] >= array1[i])
        }
    }
    
    func testsortArray2(){
        let array2 = ViewController.sortArray([2,2,2,2])
        for i in 0 ..< (array2.count - 1){
            XCTAssertTrue(array2[i + 1] >= array2[i])
        }
    }
    
    func testsortArray3(){
        let array3 = ViewController.sortArray([7,0,6,5,9,6,8])
        for i in 0 ..< (array3.count - 1){
            XCTAssertTrue(array3[i + 1] >= array3[i])
        }
    }
    
    func testsortArray4(){
        let array4 = ViewController.sortArray([1])
        for i in 0 ..< (array4.count - 1){
            XCTAssertTrue(array4[i + 1] >= array4[i])
        }
    }
    
    func testsortArray5(){
        let array5 = ViewController.sortArray([9,5])
        for i in 0 ..< (array5.count - 1){
            XCTAssertTrue(array5[i + 1] >= array5[i])
        }
    }

    

    
    
    
    
    
}
