//
//  ListIssuesViewController.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import RxSwift

extension ListIssuesViewController: ListIssuesRouterDataSource {}

extension ListIssuesViewController: ListIssuesRouterDataDestination {}

class ListIssuesViewController: UIViewController {
    var router: ListIssuesRouter!
    
    var id: Int = -1 {
        didSet {
            guard id != -1 else { return }
            router.navigateToShowIssueScene()
        }
    }
    
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
        case networkError
    }
    
    let disposeBag: DisposeBag = DisposeBag()

    var state: State = .fetching {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var issues: [Issue] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        router = ListIssuesRouter(viewController: self, dataSource: self, dataDestination: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerUINibs()
        
        state = .fetching
        // Do any additional setup after loading the view.
    }
    
    func registerUINibs() {
        collectionView.register(UINib(nibName: IndicatorCell.nibName, bundle: nil), forCellWithReuseIdentifier: IndicatorCell.reuseIdentifier)
        collectionView.register(UINib(nibName: ListIssueCell.nibName, bundle: nil), forCellWithReuseIdentifier: ListIssueCell.reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch state {
        case .fetching, .networkError: fetchIssues()
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ListIssuesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < issues.count, let id = issues[indexPath.item].id else { return }
        self.id = id
    }
}

extension ListIssuesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case .fetching:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndicatorCell.reuseIdentifier, for: indexPath) as! IndicatorCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListIssueCell.reuseIdentifier, for: indexPath) as! ListIssueCell
            cell.configure(issue: issues[indexPath.item])
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.number
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .fetching, .networkError: return 1
        case .fetched: return issues.count
        }
    }
}

extension ListIssuesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch state {
        case .fetching, .networkError: return collectionView.bounds.size
        case .fetched: return CGSize(width: collectionView.width, height: ListIssueCell.height)
        }
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
