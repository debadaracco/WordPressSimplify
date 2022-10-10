//
//  DetailViewController.swift
//  iOS Example
//
//  Created by Diego Badaracco on 21/09/2022.
//

import UIKit
import WordPressSimplify
import UIScrollView_InfiniteScroll

class DetailViewController: UIViewController {
    enum RestClients: String, CaseIterable {
        case alamofire
        case ´default´
        
        var wpNetworkingClientStrategy: WPNetworkingClientStrategy? {
            switch self {
            case .´default´:
                return nil
            case .alamofire:
                return AlamofireWPNetworkingImp()
            }
        }
        
    }
    enum WPType: String, CaseIterable {
        case categories
        case comments
        case media
        case pages
        case posts
        case tags
        case users
    }
    var baseURL: String!
    var wpType: WPType!
    var restClient: RestClients = .´default´
    private var wordpressSimplify: WordPressSimplify!
    @IBOutlet weak var tableView: UITableView!
    private var items: [ContentListeable] = [ContentListeable]()
    
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
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.wordpressSimplify = WordPressSimplify(
            baseURL: self.baseURL,
            networkingClientStrategy: self.restClient.wpNetworkingClientStrategy
        )
        
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
    private func loadData() {
        let page = 1
        let perPage = 30
        switch self.wpType {
        case .comments:
            self.wordpressSimplify.fetchComments(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .media:
            self.wordpressSimplify.fetchMedias(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .users:
            self.wordpressSimplify.fetchUsers(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .categories:
            self.wordpressSimplify.fetchCategories(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .tags:
            self.wordpressSimplify.fetchTags(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .posts:
            self.wordpressSimplify.fetchPosts(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadDataComplete
            )
        case .pages:
            self.wordpressSimplify.fetchPages(
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
            self.wordpressSimplify.fetchComments(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .media:
            self.wordpressSimplify.fetchMedias(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .users:
            self.wordpressSimplify.fetchUsers(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .categories:
            self.wordpressSimplify.fetchCategories(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .tags:
            self.wordpressSimplify.fetchTags(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .posts:
            self.wordpressSimplify.fetchPosts(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.onLoadMoreComplete
            )
        case .pages:
            self.wordpressSimplify.fetchPages(
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

    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension DetailViewController: UITableViewDataSource {
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
        return cell
    }
}

protocol ContentListeable {
    var listeableTitle: String {get}
}

extension WPUser: ContentListeable {
    var listeableTitle: String {
        return self.name
    }
}

extension WPCategory: ContentListeable {
    var listeableTitle: String {
        return self.name ?? ""
    }
}

extension WPTag: ContentListeable {
    var listeableTitle: String {
        return self.name ?? ""
    }
}

extension WPPost: ContentListeable {
    var listeableTitle: String {
        return self.title?.rendered ?? ""
    }
}

extension WPPage: ContentListeable {
    var listeableTitle: String {
        return self.title?.rendered ?? ""
    }
}

extension WPMedia: ContentListeable {
    var listeableTitle: String {
        return self.title?.rendered ?? ""
    }
}
extension WPComment: ContentListeable {
    var listeableTitle: String {
        return self.content?.rendered ?? ""
    }
}
