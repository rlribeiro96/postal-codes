//
//  PostalListViewController.swift
//  WTest
//
//  Created by Ricardo Ribeiro on 08/10/22.
//

import UIKit

class PostalListViewController: UIViewController, LoadingIndicatorProtocol {
    
    let cellReuseIdentifier = "cell"
    var viewModel: PostalListViewModel?
    
    private var customView: PostalListView {
        guard let view = view as? PostalListView else { fatalError() }
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.downloadPostalListFile()
        definesPresentationContext = false
    }
    
    override func loadView() {
        super.loadView()
        
        view = PostalListView()
        customView.render()
        setupSearchBar()
        setupTableView()
    }
    
    func showLoading() {
        customView.showLoading()
    }
    
    func hideLoading() {
        customView.hideLoading()
    }
}

// MARK: SearchBar

extension PostalListViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    
    private func setupSearchBar() {
        customView.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            viewModel?.searchPostalCodes(searchTerm: searchText)
        }
        customView.reloadTableViewData()
    }
}

// MARK: UITableView

extension PostalListViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        customView.postalListTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        customView.postalListTableView.delegate = self
        customView.postalListTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.searchResult.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = customView.postalListTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        
        cell.textLabel?.text = viewModel?.searchResult[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}
