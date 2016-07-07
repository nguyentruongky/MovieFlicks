//
//  MovieListDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension MovieListViewController: HomeSectionDelegate {
    
    func showMovieDetail(movie: Movie) {
        let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        detail.data = movie
        navigationController?.pushViewController(detail, animated: true)
    }
    
    // empty func
    func showListWithData(movies: [Movie], title: String) {
        
    }
}