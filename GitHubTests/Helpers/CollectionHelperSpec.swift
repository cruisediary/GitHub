//
//  CollectionHelperSpec.swift
//  GitHub
//
//  Created by CruzDiary on 27/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import XCTest

import Quick
import Nimble

@testable import GitHub
class CollectionHelperSpec: QuickSpec {
    override func spec() {
        var item: Int? = nil
        describe("subscript (safe index: Index)") {
            context("when item at index 2 of empty array") {
                beforeEach {
                    let emptyArray: [Int] = []
                    item = emptyArray[safe: 2]
                }
                
                it("item should be nil") {
                    expect(item).to(beNil())
                }
            }
            
            context("when item at index 2 of [1, 2, 3]") {
                beforeEach {
                    let array: [Int] = [1, 2, 3]
                    item = array[safe: 2]
                }
                
                it("item should be 3") {
                    expect(item).to(equal(3))
                }
            }
        }
    }
}
