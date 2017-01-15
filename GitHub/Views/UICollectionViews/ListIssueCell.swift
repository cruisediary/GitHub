//
//  ListIssueCell.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

class ListIssueCell: UICollectionViewCell {
    static let nibName = "ListIssueCell"
    static let reuseIdentifier = "ListIssueCell"
    static let height: CGFloat = 64

    @IBOutlet weak var repoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var opendInfoLabel: UILabel!
    @IBOutlet weak var issueNumberLabel: UILabel!
    
    func configure(issue: Issue) {
        guard let number = issue.number else { return }
        repoLabel.text = issue.url
        titleLabel.text = issue.title
        issueNumberLabel.text = "#\(number)"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
