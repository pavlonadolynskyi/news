//
//  FeedViewController.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    var presenter: FeedPresentation?
    
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

extension FeedViewController: FeedView {
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

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = presenter?.sections else { fatalError() }

        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = presenter?.sections else { fatalError() }

        let section = sections[section]
        switch section {
        case .items(let items):
            return items.count
        case .noItems:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sections = presenter?.sections else { fatalError() }

        let section = sections[indexPath.section]
        switch section {
        case .items(let posts):
            let cell: TextCell = tableView.cell(for: indexPath)
            let post = posts[indexPath.row]
            cell.show(text: post.title)
            return cell
        case .noItems(let message):
            let cell: NoContentTableCell = tableView.cell(for: indexPath)
            cell.show(info: message)
            return cell
        }
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sections = presenter?.sections else { fatalError() }

        let section = sections[indexPath.section]
        switch section {
        case .items:
            return TextCell.heightFor(tableView.bounds.size)
        case .noItems:
            return tableView.bounds.height
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sections = presenter?.sections else { fatalError() }

        let section = sections[indexPath.section]
        if case .items(let posts) = section {
            let post = posts[indexPath.row]
            presenter?.showDetails(post)
        }
    }
}
