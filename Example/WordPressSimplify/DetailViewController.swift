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
    enum WPType: String, CaseIterable {
        case users
        case categories
    }
    var baseURL: String!
    var wpType: WPType!
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
        self.wordpressSimplify = WordPressSimplify(baseURL: self.baseURL)
        
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
        return self.name
    }
}
