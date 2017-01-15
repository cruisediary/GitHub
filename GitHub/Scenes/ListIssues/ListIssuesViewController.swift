//
//  ListIssuesViewController.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import RxSwift

class ListIssuesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    struct Constant {
        static let userName = "Instagram"
        static let repo = "IGListKit"
    }
    
    enum Section {
        static let number = 1
    }
    
    enum State {
        case fetching
        case fetched
        case networkdError
    }
    
    let disposeBag: DisposeBag = DisposeBag()

    var state: State = .fetching {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var issues: [Issue] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: ListIssueCell.nibName, bundle: nil), forCellWithReuseIdentifier: ListIssueCell.reuseIdentifier)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch state {
        case .fetching, .networkdError: fetchIssues()
        case .fetched: break
        }
    }

    func fetchIssues() {
        let worker = IssuesWorker(service: IssuesService())
        worker.fetchIssues(request: FetchIssues.Request(userName: Constant.userName, repo: Constant.repo))
        .subscribe { [weak self](event) in
            guard let `self` = self, let issues = event.element else { return }
            self.issues = issues
            self.state = .fetched
        }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ListIssuesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListIssueCell.reuseIdentifier, for: indexPath) as! ListIssueCell
        cell.configure(issue: issues[indexPath.item])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.number
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issues.count
    }
}

extension ListIssuesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: ListIssueCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension UIView {
    var width: CGFloat {
        return bounds.width
    }
}
