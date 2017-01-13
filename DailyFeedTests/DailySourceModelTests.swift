//
//  DailySourceModelTests.swift
//  DailyFeed
//
//  Created by TrianzDev on 13/01/17.
//  Copyright © 2017 trianz. All rights reserved.
//

import XCTest
@testable import DailyFeed

class DailySourceModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testDailySourceModel() {
        
        //Mock Data
        let json: JSON = [
            "id": "abc-news-au"  as AnyObject,
            "name": "ABC News (AU)" as AnyObject,
            "category": "general" as AnyObject,
            "urlsToLogos": [
                            "small": "http://i.newsapi.org/abc-news-au-s.png",
                            "medium": "http://i.newsapi.org/abc-news-au-m.png",
                            "large": "http://i.newsapi.org/abc-news-au-l.png"
                           ] as AnyObject
                        ]
        
        let corruptJson: JSON = [
            "id": "abc-news-au"  as AnyObject,
            "category": "general" as AnyObject,
            "urlsToLogos": [
                "small": "http://i.newsapi.org/abc-news-au-s.png",
                "medium": "http://i.newsapi.org/abc-news-au-m.png",
                "large": "http://i.newsapi.org/abc-news-au-l.png"
                ] as AnyObject
        ]
        
        let model = DailySourceModel(json: json)
        
        XCTAssertNotNil(model)
        
        XCTAssertEqual(model?.id, "abc-news-au")
        XCTAssertEqual(model?.name, "ABC News (AU)")
        XCTAssertEqual(model?.category, "general")
        XCTAssertEqual(model?.urlsToLogos, "http://i.newsapi.org/abc-news-au-m.png")
        
        //test with corrupt data
        XCTAssertNil(DailyFeedModel(json: corruptJson))
    }
    
    
    
    func testGetNewsSource() {
        
        var dataModel = [DailySourceModel]()
        let exp = expectation(description: "Get Source Data")
        
        DailySourceModel.getNewsSource { (items, error) in
            guard let items = items else {
                XCTFail("Could not parse dailysource items")
                return
            }
            dataModel = items
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 11) { error in
            XCTAssertNil(error, "Fatal Error")
            XCTAssertGreaterThan(dataModel.count, 0)
        }
        
    }

    
}
