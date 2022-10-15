//
//  ListItemsViewController.swift
//  iOS Example
//
//  Created by Diego Badaracco on 21/09/2022.
//

import UIKit
import WordPressSimplify
import UIScrollView_InfiniteScroll
import AlamofireImage

class ListItemsViewController: UIViewController {
    
    var wpType: WPType!
    
    @IBOutlet weak var tableView: UITableView!
    private var items: [ContentListeable] = [ContentListeable]()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(ListItemsViewController.pullToRefresh(_:)),
            for: .valueChanged
        )
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.tableView.refreshControl = self.refreshControl
        self.tableView.addSubview(self.refreshControl)
        self.refreshControl.beginRefreshing()
        
        self.tableView.addInfiniteScroll { [weak wSelf = self] _ in
            guard let sSelf = wSelf else {
                return
            }
            sSelf.loadMoreData()
        }
        self.title = self.wpType.rawValue.capitalized
        
        self.loadData()
    }

    @objc func pullToRefresh(_ sender: Any) {
        self.loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController, let post = sender as? WPPostModel {
            vc.post = post
        }
    }
    
    private func loadData() {
        let page = 1
        let perPage = 30
        switch self.wpType {
        case .comments:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchComments(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .media:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchMedias(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .users:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchUsers(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .categories:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchCategories(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .tags:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchTags(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .posts:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchPosts(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .pages:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchPages(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                fields: [.id, .title],
                completion: self.onLoadDataComplete
            )
        case .none:
            break
        }
    }

    func onLoadDataComplete<T: ContentListeable>(_ result: Result<[T], Error>) {
        self.tableView.refreshControl?.endRefreshing()
        switch result {
        case .success(let items):
            self.items = items
            self.tableView.reloadData()
        case .failure(let error):
            self.showError(error)
        }
    }
    
    private func loadMoreData() {
        let perPage = 30
        let page = (self.items.count / perPage) + 1
        
        if self.items.count < perPage {
            self.tableView.finishInfiniteScroll()
            return
        }
        
        switch self.wpType {
        case .comments:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchComments(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .media:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchMedias(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .users:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchUsers(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .categories:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchCategories(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .tags:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchTags(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .posts:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchPosts(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .pages:
            WordPressSimplifyManager.shared.wordpressSimplify.fetchPages(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                fields: [.id, .title],
                completion: self.onLoadMoreComplete
            )
        case .none:
            break
        }
    }

    func onLoadMoreComplete<T: ContentListeable>(_ result: Result<[T], Error>) {
        self.tableView.finishInfiniteScroll()
        switch result {
        case .success(let items):
            self.items.append(contentsOf: items)
            self.tableView.reloadData()
        case .failure(let error):
            self.showError(error)
        }
    }
}

extension ListItemsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBasic", for: indexPath)
        let item = self.items[indexPath.row]
        cell.textLabel?.text = item.listeableTitle
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.imageView?.af.cancelImageRequest()
        
        if let imageURL = item.imageURL {
            cell.imageView?.af.setImage(withURL: imageURL)
        }
        
        return cell
    }
}

extension ListItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if let post =  self.items[indexPath.row] as? WPPostModel {
            self.performSegue(withIdentifier: "SelectPost", sender: post)
        } else {
            cell?.isSelected = false
        }
    }
}
