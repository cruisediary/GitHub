//
//  ListIssuesPresenter.swift
//  GitHub
//
//  Created by CruzDiary on 27/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

protocol ListIssuesPresenterInput {}

protocol ListIssuesPresenterOutput: class {}

class ListIssuesPresenter: ListIssuesPresenterInput {
    weak var output: ListIssuesPresenterOutput!
    var id: Int = -1
}
