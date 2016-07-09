//
//  MovieListDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
extension MovieList: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count == 0 ? 0 : movies.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieTableCell", forIndexPath: indexPath) as! MovieTableCell
        
        if indexPath.row == movies.count {
            cell.showLoading(true)
            loadMoreDelegate.loadMore()
        }
        else {
            cell.showLoading(false)
            cell.setup(movies[indexPath.row])    
        }
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.lightGrayColor().colorWithAlphaComponent(0.1) : UIColor.lightGrayColor().colorWithAlphaComponent(0.25)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard indexPath.row != movies.count else { return }
        delegate.showMovieDetail(movies[indexPath.row])
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchDelegate.showSearchBar(scrollView.contentOffset.y <= 0)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
}