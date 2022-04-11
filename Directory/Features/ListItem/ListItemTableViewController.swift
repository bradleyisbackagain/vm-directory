//
//  ListItemTableViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import UIKit

/// A `UITableViewController` that can display `ListItemViewModel`s.
final class ListItemTableViewController: UITableViewController {
    let viewModel: ListItemTableViewModel
    
    init(viewModel: ListItemTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let listItemTableViewCellReuseIdentifier = "list-cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.register(
            ListItemTableViewCell.self,
            forCellReuseIdentifier: listItemTableViewCellReuseIdentifier
        )
        
        viewModel.items.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if tableView.numberOfRows(inSection: 0) == 0 {
            loadModelData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listItemTableViewCellReuseIdentifier, for: indexPath) as! ListItemTableViewCell
        let item = viewModel.items.value[indexPath.row]
        item.configure(cell)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let item = viewModel.items.value[indexPath.row]
        return item.onSelection != nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items.value[indexPath.row]
        item.onSelection?()
    }
    
    @objc func refresh() {
        loadModelData()
    }
    
    private func loadModelData() {
        viewModel.loadData { [weak self] result in
            DispatchQueue.main.async {
                defer { self?.refreshControl?.endRefreshing() }
                switch result {
                case .success:
                    break
                case .failure(let error):
                    print("LOAD ERROR", error)
                    self?.show(error: error)
                }
            }
        }
    }
}
