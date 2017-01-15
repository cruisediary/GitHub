//
//  DateHelperSpec.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import XCTest

import Quick
import Nimble
import SwiftDate

@testable import GitHub
class DateHelperSpec: QuickSpec {
    override func spec() {
        var date: Date!
        
        describe("relativeTime") {
            context("when 15 minutes ago") {
                let expectedString = "15 minutes ago"
                beforeEach {
                    date = Date() - 15.minutes
                }
                
                it("should equal to '15 minutes ago'") {
                    expect(date.relativeTime).to(equal(expectedString))
                }
            }
            
            context("when 11 hours ago") {
                let expectedString = "11 hours ago"
                beforeEach {
                    date = Date() - 11.hours
                }
                
                it("should equal to '11 hours ago'") {
                    expect(date.relativeTime).to(equal(expectedString))
                }
            }
            
            context("when 50 hours ago") {
                let expectedString = "2 days ago"
                beforeEach {
                    date = Date() - 50.hours
                }
                
                it("should equal to '2 days ago'") {
                    expect(date.relativeTime).to(equal(expectedString))
                }
            }
            
            context("when 1 day ago") {
                let expectedString = "1 day ago"
                beforeEach {
                    date = Date() - 1.days
                }
                
                it("should equal to '1 day ago") {
                    expect(date.relativeTime).to(equal(expectedString))
                }
            }
        }
    }
}
