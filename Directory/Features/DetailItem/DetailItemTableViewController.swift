//
//  DetailItemTableViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 11/04/2022.
//

import UIKit

/// Displays a list of detail items.
class DetailItemTableViewController: UITableViewController {
    var items = [DetailItemViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let id = "detail-cell"
            let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .value1, reuseIdentifier: id)
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.detail
        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
