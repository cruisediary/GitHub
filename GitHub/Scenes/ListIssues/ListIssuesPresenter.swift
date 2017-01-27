//
//  ListIssuesPresenter.swift
//  GitHub
//
//  Created by CruzDiary on 27/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import RxSwift

protocol ListIssuesPresenterInput {
    func fetchIssues()
}

protocol ListIssuesPresenterOutput: class {
    func displayIssues(_ viewModel: ListIssues.FetchIssues.ViewModel)
}

class ListIssuesPresenter: ListIssuesPresenterInput {
    weak var output: ListIssuesPresenterOutput!
    var id: Int = -1
    let disposeBag: DisposeBag = DisposeBag()
    var worker: IssuesWorker = IssuesWorker(service: IssuesService())
    
    struct Constant {
        static let userName = "Instagram"
        static let repo = "IGListKit"
    }
    
    func fetchIssues() {
        worker.fetchIssues(request: ListIssues.Request(userName: Constant.userName, repo: Constant.repo))
            .subscribe { [weak self](event) in
                guard let `self` = self, let issues = event.element else { return }
                self.display(issues: issues)
            }.addDisposableTo(disposeBag)
    }
    
    func display(issues: [Issue]) {
        output?.displayIssues(ListIssues.FetchIssues.ViewModel(issues: issues))
    }
}
