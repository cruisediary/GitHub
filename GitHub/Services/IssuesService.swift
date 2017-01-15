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
    func fetchIssues(request: FetchIssues.Request) -> Observable<[Issue]>
}

struct FetchIssues {
    struct Request {
        var userName: String
        var repo: String
    }
    
    struct Response: Mappable {
        var issues: [Issue]?
        
        init?(map: Map) {}
        mutating func mapping(map: Map) {
            issues <- map["issues"]
        }
    }
}

class IssuesService: IssuesServiceProtocol {
    func fetchIssues(request: FetchIssues.Request) -> Observable<[Issue]> {
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire
                .request(IssuesRouter.fetchIssues(request: request))
                .responseObject { (response: DataResponse<FetchIssues.Response>) in
                    switch response.result {
                    case .success(let success):
                        if let issues = success.issues {
                            observer.onNext(issues)
                            observer.onCompleted()
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            
            return Disposables.create{
                request.cancel()
            }
        })
    }
}
