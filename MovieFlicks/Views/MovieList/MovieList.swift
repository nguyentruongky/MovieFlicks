//
//  MovieList.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MovieList: KViewBase {
    @IBOutlet weak var tableView: UITableView!
    var movies = [Movie]()
    
    var refreshControl: UIRefreshControl!
    
    var delegate: HomeSectionDelegate!
    var loadMoreDelegate : LoadMoviesDelegate!
    var searchDelegate : SearchDelegate!
    
    override func setupView() {
        tableView.registerNib(UINib(nibName: "MovieTableCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MovieTableCell")
        
        setupRefresh()
    }
    
    func setupRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.lightGrayColor()
        refreshControl.tintColor = UIColor.whiteColor()
        tableView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(reloadTable), forControlEvents: .ValueChanged)
    }
    
    func reloadTable() {
        loadMoreDelegate.reloadMovie { [unowned self] in
            self.refreshControl.endRefreshing()
        }
    }
    
    func setup(movies: [Movie]) {
        self.movies = movies
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}
