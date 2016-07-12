//
//  MovieList.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import RealmSwift

class FavouriteMovie : Object {
    dynamic var id: Int = 0
    
    convenience init(id: Int) {
        self.init()
        self.id = id
    }
//    dynamic var title: String = ""
//    dynamic var poster : String = ""
//    dynamic var overview : String = ""
}

class MovieList: KViewBase {
    @IBOutlet weak var tableView: UITableView!
    var movies = [Movie]()
    let realm = try! Realm()
    
    lazy var favouriteList: Results<FavouriteMovie> = { self.realm.objects(FavouriteMovie.self) }()
    
    var refreshControl: UIRefreshControl!
    var presentController: ((controller: UIViewController) -> Void)?
    var delegate: HomeSectionDelegate!
    var loadMoreDelegate : LoadMoviesDelegate!
    var searchDelegate : SearchDelegate!

    var favouriteButton : MGSwipeButton!
    
//    lazy var favouriteList = [Int]()
    
    override func setupView() {
        tableView.registerNib(UINib(nibName: "MovieTableCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MovieTableCell")
        
        setupRefresh()

        favouriteButton = MGSwipeButton(title: "  Like  ", backgroundColor: UIColor.redColor()) { [unowned self] (cell) -> Bool in
            
            let index = self.tableView.indexPathForCell(cell)!
            self.markFavourite(index.row, movieCell: cell as! MovieTableCell)
            return true
        }
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
