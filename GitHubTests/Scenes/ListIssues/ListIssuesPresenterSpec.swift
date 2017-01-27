//
//  ListIssuesPresenterSpec.swift
//  GitHub
//
//  Created by CruzDiary on 27/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import XCTest

import Quick
import Nimble
import RxSwift

@testable import GitHub
class ListIssuesPresenterSpec: QuickSpec {
    override func spec() {
        var sut: ListIssuesPresenter!
        beforeEach {
            sut = ListIssuesPresenter()
        }
        
        describe("fetchIssues") {
            context("when fetch requested") {
                let workerSpy = IssuesWorkerSpy(service: IssuesService())
                beforeEach {
                    sut.worker = workerSpy
                    sut.fetchIssues()
                }

                it("fetchIssues should be called") {
                    expect(workerSpy.fetchIssuesCalled).to(beTrue())
                }
            }
        }
    }
}

fileprivate class IssuesWorkerSpy: IssuesWorker {
    var fetchIssuesCalled: Bool = false
    override func fetchIssues(request: ListIssues.Request) -> Observable<[Issue]> {
        self.fetchIssuesCalled = true
        return Observable.just([])
    }
}
