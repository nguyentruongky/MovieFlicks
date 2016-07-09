//
//  HomeListCell.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class HomeListCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var showListButton: UIButton!
    
    lazy var movies = [Movie]()
    var title: String!
    var delegate : HomeSectionDelegate!
    var api: String!
    
    func setupData(movies: [Movie], title: String) {
        showListButton.addTarget(self, action: #selector(viewList), forControlEvents: .TouchUpInside)
        self.movies = movies
        sectionTitleLabel.text = title
        self.title = title
        collectionView.reloadData()
    }
    
    func viewList() {
        delegate.showListWithData(movies, title: title, api: api)
    }
}
