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
        var outputSpy: ListIssuesPresenterOutputSpy!
        
        beforeEach {
            outputSpy = ListIssuesPresenterOutputSpy()
            sut = ListIssuesPresenter()
            sut.output = outputSpy
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
        
        describe("displayIssues") {
            context("when fetch 6 issues successfully") {
                beforeEach {
                    sut.display(issues: (0...5).map { _ in return Issue() })
                }
                
                it("displayIssues should be called") {
                    expect(outputSpy.displayIssuesCalled).to(beTrue())
                }
                
                it("displayIssues count should be 6") {
                    expect(outputSpy.issuesCount).to(equal(6))
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

fileprivate class ListIssuesPresenterOutputSpy: ListIssuesPresenterOutput {
    var displayIssuesCalled: Bool = false
    var issuesCount: Int = 0
    func displayIssues(_ viewModel: ListIssues.FetchIssues.ViewModel) {
        self.displayIssuesCalled = true
        issuesCount = viewModel.numberOfItem
    }
}
