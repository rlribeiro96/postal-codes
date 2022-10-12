//
//  PostalListView.swift
//  WTest
//
//  Created by Ricardo Ribeiro on 10/10/22.
//

import Foundation
import UIKit
import SnapKit

protocol LoadingIndicatorProtocol {
    func hideLoading()
    func showLoading()
}

class PostalListView: UIView {
    
    lazy var containerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .systemBackground
        return element
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let element = UIActivityIndicatorView()
        element.color = .gray
        element.style = .large
        element.startAnimating()
        element.isHidden = true
        return element
    }()
    
    lazy var loadingView: UIView = {
        let element = UIView()
        element.addSubview(spinner)
        element.isHidden = true
        return element
    }()
    
    lazy var searchBar: UISearchBar = {
        let element = UISearchBar()
        element.searchBarStyle = UISearchBar.Style.default
        element.placeholder = " Search postal code..."
        element.isHidden = true
        return element
    }()
    
    lazy var postalListTableView: UITableView = {
        let element = UITableView()
        element.isScrollEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isHidden = true
        return element
    }()
    
    func render() {
        defineViewHierarchy()
        configureConstraints()
        reloadTableViewData()
    }
    
    private func defineViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(loadingView)
        containerView.addSubview(searchBar)
        containerView.addSubview(postalListTableView)
        loadingView.addSubview(spinner)
    }
    
    private func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        searchBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        postalListTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    func reloadTableViewData() {
        postalListTableView.reloadData()
    }
    
    func showLoading(){
        loadingView.isHidden = false
        spinner.isHidden = false
    }
    
    func hideLoading() {
        loadingView.isHidden = true
        spinner.isHidden = true
        searchBar.isHidden = false
        postalListTableView.isHidden = false
    }
}
