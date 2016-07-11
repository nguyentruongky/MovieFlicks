//
//  MovieGrid.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MovieGrid: KViewBase {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [Movie]!
    var delegate: HomeSectionDelegate!
    var loadMoreDelegate : LoadMoviesDelegate!

    override func setupView() {
        collectionView.registerNib(UINib(nibName: "MovieCollectionCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "MovieCollectionCell")
    
    }
    
    func setup(movies: [Movie]) {
        self.movies = movies
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}
