//
//  HomeControllerDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

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
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: HomeSectionDelegate {
    
    func showMovieDetail(movie: Movie) {
        
    }
    
    func showListWithData(movies: [Movie], title: String) {
        let controller = UIStoryboard(name: sb_Main, bundle: nil).instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        controller.movies = movies
        controller.title = title
        navigationController?.pushViewController(controller, animated: true)
    }
}