//
//  ListIssuesUITests.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import XCTest

class ListIssuesUITests: UITestCase {
    
    func testUI() {
        XCTAssertTrue(app.collectionViews.element.exists)
    }
}
