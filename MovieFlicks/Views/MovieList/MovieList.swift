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
    
    var delegate: HomeSectionDelegate!
    var loadMoreDelegate : LoadMoreMoviesDelegate!
    var listKind : ListKind!
    var api: String!
    
    override func setupView() {
        tableView.registerNib(UINib(nibName: "MovieTableCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MovieTableCell")
    }
    
    func setup(movies: [Movie]) {
        self.movies = movies
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}
