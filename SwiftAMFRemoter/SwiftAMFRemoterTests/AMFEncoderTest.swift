//
//  AMFEncoderTest.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import XCTest
@testable import SwiftAMFRemoter

class EncoderTest: XCTestCase {
    
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEncodeDecode() {
        
        //return
        print("")
        print("-------------------------")
        print("- AMF Encoder")
        print("-------------------------")
        print("")

        
        //        XCTAssertTrue(RemoteServiceManager.sharedInstance.serviceCongurationExists(testKey), "Expecting true for ServiceConfiguration Existing...")
        //        //XCTAssertEqual(vo.result, 24, "my test")
        //
        //
        
        //AMF3Coder.verboseDebug = true
        let coder:AMF3Coder = AMF3Coder();
        
//        coder.registerClassNameAlias(TestAMFClass())
//        coder.registerClassNameAlias(TestAMFClass2())
        
        var value:ASArray? = nil
        var bytesCount:Int=0
//        let myCustom:TestAMFClass = TestAMFClass()
//        
//        myCustom.isBestNum = 43
//        myCustom.isCool = true
//        myCustom.bigData["Joy"]="1"
//        myCustom.bigData["Tony"] = 2
//        myCustom.bigData["Jackson"] = "Joy"
//        myCustom.bigData["Jill"] = 3
//        
//        //let myCustom2:TestAMFClass = myCustom
//        let myCustom2:TestAMFClass = TestAMFClass()
//        myCustom2.isBestNum = 53
//        myCustom2.isCool = true
//        myCustom2.bigData["willy"]="4"
//        myCustom2.bigData["joby"] = 9
//        myCustom2.bigData["whiny"] = "ron"
//        myCustom2.bigData["whiskey"] = 10
        
        // Strict Array
        var myArr:ASArray = ASArray()
        
        let max = 2
        var counter=0
        var startIdx = 0
        
        for i in startIdx..<max{
            
            let myCustom:TestAMFClass = TestAMFClass()
            myCustom.isBestNum = 43
            myCustom.isCool = true
            myCustom.bigData["Joy"]="1"
            myCustom.bigData["Tony"] = 2
            myCustom.bigData["Jackson"] = "Joy"
            myCustom.bigData["Jill"] = 3
            
            myArr[i] = myCustom
            counter = i
        }
        
        startIdx = counter
        
        for i in startIdx..<(max*2){

            let myCustom2:TestAMFClass2 = TestAMFClass2()
            myCustom2.isBestNum = 53
            myCustom2.isCool = true
            myCustom2.bigData["willy"]="4"
            myCustom2.bigData["joby"] = 9
            myCustom2.bigData["whiny"] = "ron"
            myCustom2.bigData["whiskey"] = 10.2
            
            myArr[i] = myCustom2
            counter = i
        }
 
        var testArr6:ASArray =  ASArray()
        testArr6["Joy"]="1"
        testArr6["Tony"] = 2
        testArr6["Jackson"] = "Joy"
        testArr6["Jill"] = -33
        
        let testDate:Date = Date()
        //let testArr0:ASArray = ["Joy", "Maverick", "Jackson"]
        //let testArr1:ASArray = [myCustom, "Tony", "Ghoul", true, "Tony1", "This is fricken awesomes", -44, testDate, testArr6, myCustom2]
        //let testArr1:ASArray = [ "Bill", "Tony", "Ghoul", testDate, "John", "Tony", testArr6]
        //let testArr1:ASArray = [ myCustom, myCustom2 ]
        
        coder.encodeValue(myArr)
        coder.position = 0
        
        
        do {
            
            print("Bytes: \(coder.bytes.count)")
            value = try coder.decodeValue(nil) as? ASArray
            
            // Strict Array
            for i in 0..<(value?.data.count)!{
                
                print("-------------------------")
                
                switch(value?.data[i]){
                    
                case let t1 as TestAMFClass:
                    print("\n-------------------------")
                    print("- TestAMFClass")
                    print("-------------------------")
                    print(t1.isBestNum)
                    print(t1.isCool)
                    print(t1.bigData.dict.count)
                    
                    for (key, value) in t1.bigData.dict {
                        print("Property: \"\(key )\" - value: \(value!)")
                    }
                    
                    break
                    
                case let t2 as TestAMFClass2:
                    print("\n-------------------------")
                    print("- TestAMFClass2")
                    print("-------------------------")
                    print(t2.isBestNum)
                    print(t2.isCool)
                    print(t2.bigData.dict.count)
                    
                    for (key, value) in t2.bigData.dict {
                        print("Property: \"\(key )\" - value: \(value!)")
                    }
                    
                    break
                    
                case let t3 as ASObject:
                    
                    print("\n-------------------------")
                    print("- ASObject")
                    print("-------------------------")
                    for (key, value) in t3.properties {
                        print("Property: \"\(key )\" - value: \(value!)")
                    }
                    
                    break
                    
                default:
                    print("not found")
                    
                }
                
            }
            
            
            //            if let tiny:TestAMFClass2 = value?.data[(value?.data.count)!-1] as! SwiftAMFManagerTests.TestAMFClass2?{
            //                print(tiny.isBestNum)
            //                print(tiny.isCool)
            //                print(tiny.bigData.dict.count)
            //
            //                for (key, value) in tiny.bigData.dict {
            //
            //
            //
            //                    print("Property: \"\(key )\" - value: \(value!)")
            //                }
            //
            //            }
            
            
            var test = ""
            //            // 3
            //value! = try coder.decode() as ASArray
            //            //value = try reader.deserialize(bytes)
        }
            //            // 4
        catch let e as Error {
            print(e.localizedDescription)
        }
        
        //print(coder.description)
        
        bytesCount += coder.bytes.count
        
        print("")
        print("")
        //XCTAssertEqual(bytesCount,93, "Byte count isn't equal...")
    }

    ////////////////////////////////////////
    /// Test Data
    ////////////////////////////////////////
    //@objc(TestAMFClass) open class TestAMFClass:ASObject{
    @objc(TestAMFClass2) open class TestAMFClass2:BasicObject{
        
        var isCool:Bool = false
        var isBestNum:Int = 44
        var bigData:ASArray =  ASArray()
        
        required public init() {
            
            super.init()
            
            remoteClassAlias = "TestAMFClass2.some.package.com"
            
        }
        
        //override open var debugDescription: String {return "I am a Tony"}
        override open var description : String {return "TestAMFClass2"}
        
        //        subscript(key: String) -> Any? {
        //            get {
        //                if key == "bigData" {
        //                    return bigData
        //                } else if key == "isCool" {
        //                    return isCool
        //                }
        //                else if key == "isBestNum" {
        //                    return isBestNum
        //                }
        //
        //                return nil
        //            }
        //            set {
        //                if key == "bigData" {
        //                    bigData = newValue as! ASArray
        //                } else if key == "isCool" {
        //                    isCool = (newValue != nil)
        //                }
        //                else if key == "isBestNum" {
        //                    isBestNum = newValue as! Int
        //                }
        //            }
        //        }
        //override init() {}
    }
    
    
    //@objc(TestAMFClass) open class TestAMFClass:ASObject{
    @objc(TestAMFClass) open class TestAMFClass:BasicObject{
        
        var isCool:Bool = false
        var isBestNum:Int = 44
        var bigData:ASArray =  ASArray()
        
        required public init() {
            
            super.init()
            
            remoteClassAlias = "TestAMFClass.some.package.com"
            
        }

        
        
        
        //override open var debugDescription: String {return "I am a Tony"}
        override open var description : String {return "TestAMFClass"}
        
        //       subscript(key: String) -> Any? {
        //            get {
        //                if key == "bigData" {
        //                    return bigData
        //                } else if key == "isCool" {
        //                    return isCool
        //                }
        //                else if key == "isBestNum" {
        //                    return isBestNum
        //                }
        //
        //                return nil
        //            }
        //            set {
        //                if key == "bigData" {
        //                    bigData = newValue as! ASArray
        //                } else if key == "isCool" {
        //                    isCool = (newValue != nil)
        //                }
        //                else if key == "isBestNum" {
        //                    isBestNum = newValue as! Int
        //                }
        //            }
        //        }
        //override init() {}
    }

    
}
