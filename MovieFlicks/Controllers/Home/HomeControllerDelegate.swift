//
//  HomeControllerDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

protocol LoadMoreMoviesDelegate {
    
    func loadMore()
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = self.data[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeListCell", forIndexPath: indexPath) as! HomeListCell
        cell.setupData(data.movies, title: data.title)
        cell.api = apis[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: HomeSectionDelegate {
    
    func showMovieDetail(movie: Movie) {
        let controller = UIStoryboard(name: sb_Main, bundle: nil).instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        controller.data = movie
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showListWithData(movies: [Movie], title: String, api: String) {
        let controller = UIStoryboard(name: sb_Main, bundle: nil).instantiateViewControllerWithIdentifier("MovieListViewController") as! MovieListViewController
        controller.movies = movies
        controller.title = title
        controller.delegate = self
        controller.api = api
        navigationController?.pushViewController(controller, animated: true)
    }
  
}