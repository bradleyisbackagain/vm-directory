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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if tableView.numberOfRows(inSection: 0) == 0 {
            loadModelData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: use custom cells
        let id = "demo"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .subtitle, reuseIdentifier: id)
        let item = viewModel.items[indexPath.row]
        let configurator = ListItemViewModelCellConfigurator(item: item)
        configurator.configure(cell: cell)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount()
    }
    
    @objc func refresh() {
        loadModelData()
    }
    
    private func loadModelData() {
        viewModel.loadData { [weak self] result in
            defer { self?.refreshControl?.endRefreshing() }
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure(let error):
                // TODO: surface error
                print(error)
            }
        }
    }
}

struct ListItemViewModelCellConfigurator {
    let item: ListItemViewModel
    
    func configure(cell: UITableViewCell) {
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
    }
}
