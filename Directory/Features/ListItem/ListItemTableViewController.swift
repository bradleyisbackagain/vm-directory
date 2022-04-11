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
    
    /// Temporary cache when searching for items, these are the items that match the query.
    private var filteredItems = [ListItemViewModel]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var dataSource: [ListItemViewModel] {
        isSearchBarEmpty ? viewModel.items.value : filteredItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.register(
            ListItemTableViewCell.self,
            forCellReuseIdentifier: listItemTableViewCellReuseIdentifier
        )
        
        viewModel.items.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
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
        let item = dataSource[indexPath.row]
        item.configure(cell)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let item = dataSource[indexPath.row]
        return item.onSelection != nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource[indexPath.row]
        item.onSelection?()
    }
    
    @objc func refresh() {
        loadModelData()
    }
    
    private func loadModelData() {
        refreshControl?.beginRefreshing()
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

extension ListItemTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filter(searchText: searchBar.text ?? "")
    }
    
    func filter(searchText: String) {
        filteredItems = viewModel.items.value.filter { item in
            item.matchesQuery(searchText)
        }
        tableView.reloadData()
    }
}
