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
class ListIssuesViewControllerSpec: QuickSpec {
    
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
            
            it("numberOfSections") {
                expect(sut.collectionView.numberOfSections).to(equal(1))
            }
            
            context("when fetch 10 items") {
                let expectedNum = 10
                beforeEach {
                    sut.issues = IssueSeeder.generate(num: expectedNum)
                    sut.state = .fetched
                }
                
                it("numberOfItems should be \(expectedNum)") {
                    expect(sut.collectionView.numberOfItems(inSection: 0)).to(equal(expectedNum))
                }
            }
        }
    }
}

class IssueSeeder {
    static func generate(num: Int) -> [Issue] {
        return (0..<num).map { _ in Issue() }
    }
}
