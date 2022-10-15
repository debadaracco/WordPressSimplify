//
//  DetailViewController.swift
//  WordPressSimplify_Example
//
//  Created by Diego Badaracco on 15/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import WordPressSimplify

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var items: [ContentListeable] = [ContentListeable]()
    var post: WPPostModel!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(DetailViewController.pullToRefresh(_:)),
            for: .valueChanged
        )
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Post: \(self.post.id!)"
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.refreshControl = self.refreshControl
        
        self.refreshControl.beginRefreshing()
        self.pullToRefresh(self.refreshControl)
        
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        WordPressSimplifyManager.shared.wordpressSimplify.fetchRelated(
            for: self.post
        ) { result in
            switch result {
            case .success(let related):
                
                DispatchQueue.main.async {
                    self.items.removeAll()
                    
                    if let post = related.post as? WPPost {
                        self.items.append(post)
                    }
                    
                    
                    if let categories = related.categories as? [WPCategory] {
                        self.items.append(contentsOf: categories)
                    }
                    
                    if let media = related.media as? WPMedia {
                        self.items.append(media)
                    }
                    
                    if let user = related.user as? WPUser {
                        self.items.append(user)
                    }
                    
                    if let tags = related.tags as? [WPTag] {
                        self.items.append(contentsOf: tags)
                    }
                    
                    if let comments = related.comments as? [WPComment] {
                        self.items.append(contentsOf: comments)
                    }
                    
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
                
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.showError(error)
                }
                break
            }
        }
    }

}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        cell.textLabel?.text = "\(Mirror(reflecting: item).description) - \(item.listeableTitle)"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        return cell
        
    }
    
    
    
    
}

