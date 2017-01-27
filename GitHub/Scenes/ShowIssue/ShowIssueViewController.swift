//
//  ShowIssueViewController.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import RxSwift

extension ShowIssueViewController: ShowIssueRouterDataSource {}

extension ShowIssueViewController: ShowIssueRouterDataDestination {}

class ShowIssueViewController: UIViewController {
    static let segue = "ShowIssueScene"
    var router: ShowIssueRouter!
    var id: Int = -1
    
    enum State {
        case fetching
        case fetched
        case networkError
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    var state: State = .fetching {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var issue: Issue?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        router = ShowIssueRouter(viewController: self, dataSource: self, dataDestination: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "\(id)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ShowIssueViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}

extension ShowIssueViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .zero
    }
}
