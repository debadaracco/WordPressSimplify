//
//  ViewController.swift
//  WordPressSimplifyExample
//
//  Created by Diego Badaracco on 20/09/2022.
//

import UIKit

class ViewController: UIViewController {
    fileprivate let elements = DetailViewController.WPType.allCases

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var baseURLTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "DetailSegueStoryboard" {
            let detail = segue.destination as! DetailViewController
            detail.baseURL = self.baseURLTextField.text!

            if let sender = sender as? DetailViewController.WPType {
                detail.wpType = sender
            }
        }
    }

    func validateData(_ element: DetailViewController.WPType) -> Bool {
        guard let text = self.baseURLTextField.text else {
            showBaseURLAlert()
            return false
        }

        guard let url = URL(string: text), !url.absoluteString.isEmpty else {
            showBaseURLAlert()
            return false
        }

        return true
    }
}

extension ViewController {
    func showBaseURLAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "You must set valid base url wordpress site",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .cancel))

        self.present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPTypeSelectorCell", for: indexPath)
        cell.textLabel?.text = self.elements[indexPath.row].rawValue
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = self.elements[indexPath.row]
        if self.validateData(element) {
            self.performSegue(withIdentifier: "DetailSegueStoryboard", sender: element)
        }
    }
}
