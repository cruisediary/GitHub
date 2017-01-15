//
//  IssuesWorker.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import RxSwift

final class IssuesWorker {
    let service: IssuesServiceProtocol
    init(service: IssuesServiceProtocol) {
        self.service = service
    }
    
    func fetchIssues(request: FetchIssues.Request) -> Observable<[Issue]> {
        return service.fetchIssues(request: request)
    }
}
