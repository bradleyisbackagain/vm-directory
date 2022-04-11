//
//  ListItemTableViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import UIKit

final class ListItemTableViewController: UITableViewController {
    
    // TODO: inject data source
    let data = ["one", "two", "three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: use custom cells
        let id = "demo"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
}
