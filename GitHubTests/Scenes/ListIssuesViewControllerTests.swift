//
//  ListIssuesViewControllerTests.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import XCTest

import Quick
import Nimble

@testable import GitHub
class ListIssuesViewControllerTests: QuickSpec {
    
    override func spec() {
        var sut: ListIssuesViewController!
        var window: UIWindow!
        
        beforeEach {
            window = UIWindow()
            let storyboard = UIStoryboard(name: "ListIssues", bundle: nil)
            sut = storyboard.instantiateViewController(withIdentifier: "ListIssuesViewController") as! ListIssuesViewController
            window.addSubview(sut.view)
            RunLoop.current.run(until: Date())
        }
        
        describe("collectionView") {
            it("delegate, datasource should be not nil") {
                expect(sut.collectionView.delegate).toNot(beNil())
                expect(sut.collectionView.dataSource).toNot(beNil())
            }
        }
    }
}
