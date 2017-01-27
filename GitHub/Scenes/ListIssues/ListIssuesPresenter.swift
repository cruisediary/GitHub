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
    
    struct Constant {
        static let userName = "Instagram"
        static let repo = "IGListKit"
    }
    
    func fetchIssues() {
        let worker = IssuesWorker(service: IssuesService())
        worker.fetchIssues(request: ListIssues.Request(userName: Constant.userName, repo: Constant.repo))
            .subscribe { [weak self](event) in
                guard let `self` = self, let issues = event.element else { return }
                self.output.displayIssues(ListIssues.FetchIssues.ViewModel(issues: issues))
            }.addDisposableTo(disposeBag)
    }
}
