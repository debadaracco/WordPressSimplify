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
        case user
    }
    var baseURL: String!
    var wpType: WPType!
    private var wordpressSimplify: WordPressSimplify!
    @IBOutlet weak var tableView: UITableView!
    private var items: [ContentListeable] = [ContentListeable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.wordpressSimplify = WordPressSimplify(baseURL: self.baseURL)
        self.tableView.addInfiniteScroll { [weak wSelf = self] _ in
            guard let sSelf = wSelf else {
                return
            }
            sSelf.loadMoreData()
        }
        self.title = self.wpType.rawValue.capitalized
        self.loadData()
    }

    private func loadData() {
        let page = 1
        let perPage = 30
        switch self.wpType {
        case .user:
            self.wordpressSimplify.fetchUsers(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ],
                completion: self.complete
            )
        case .none:
            break
        }
    }

    private func loadMoreData() {
        let perPage = 30
        let page = (self.items.count / perPage) + 1
        switch self.wpType {
        case .user:
            self.wordpressSimplify.fetchUsers(
                filters: [
                    .page(number: page),
                    .perPage(number: perPage)
                ]
            ) { [weak wSelf = self] result in
                wSelf?.tableView.finishInfiniteScroll()
                wSelf?.complete(result)
            }
        case .none:
            break
        }
    }

    func complete(_ result: Result<[WPUser], Error>) {
        switch result {
        case .success(let users):
            self.items.append(contentsOf: users)
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
