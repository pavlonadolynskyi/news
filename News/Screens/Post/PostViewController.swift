//
//  PostViewController.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    var presenter: PostPresentation?
    
    @IBOutlet private weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = presenter?.title
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.frame.height
        
        tableView.tableFooterView = UIView()
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        TextCell.registerNib(tableView)
        NoContentTableCell.registerNib(tableView)
        
        presenter?.viewDidLoad()
    }
    
    @objc private func handleRefresh() {
        presenter?.refresh()
    }
}

extension PostViewController: PostView {
    func updateContent() {
        tableView.reloadData()
    }
    
    func setRefreshing(_ on: Bool) {
        if on {
            refreshControl.beginRefreshing()
        } else {
            refreshControl.endRefreshing()
        }
    }
}

extension PostViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = presenter?.sections else { fatalError() }
        
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = presenter?.sections else { fatalError() }
        
        
        let section = sections[section]
        switch section {
        case .header, .text, .user, .noContent:
            return 1
        case .comments(let comments):
            return comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sections = presenter?.sections else { fatalError() }
        
        let section = sections[indexPath.section]
        switch section {
        case .header(let text):
            let cell: TextCell = tableView.cell(for: indexPath)
            cell.show(text: text.uppercased())
            return cell
        case .text(let text):
            let cell: TextCell = tableView.cell(for: indexPath)
            cell.show(text: text)
            return cell
        case .user(let user):
            let cell: TextCell = tableView.cell(for: indexPath)
            cell.show(text: user.name)
            return cell
        case .comments(let comments):
            let cell: TextCell = tableView.cell(for: indexPath)
            let comment = comments[indexPath.row]
            let text = "\(comment.name):\n\(comment.body)"
            cell.show(text: text)
            return cell
        case .noContent(let message):
            let cell: NoContentTableCell = tableView.cell(for: indexPath)
            cell.show(info: message)
            return cell
        }
    }
}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sections = presenter?.sections else { fatalError() }
        
        let section = sections[indexPath.section]
        switch section {
        case .header, .text, .user, .comments:
            return TextCell.heightFor(tableView.bounds.size)
        case .noContent:
            return 200
        }
    }
}
