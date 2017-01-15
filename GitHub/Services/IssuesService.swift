//
//  IssuesService.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RxSwift

protocol IssuesServiceProtocol {
    func fetchIssues(request: ListIssues.Request) -> Observable<[Issue]>
}

class IssuesService: IssuesServiceProtocol {
    func fetchIssues(request: ListIssues.Request) -> Observable<[Issue]> {
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(IssuesRouter.fetchIssues(request: request)).responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .success:
                    if let json = response.result.value as? [[String: Any]],
                        let issues = Mapper<Issue>().mapArray(JSONArray: json) {
                        observer.onNext(issues)
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create{
                request.cancel()
            }
        })
    }
}
