//
//  HomeCollectionCell.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    func setupData(movie: Movie) {
        
        posterImageView.downloadImageWithUrlString("\(smallPoster)\(movie.poster!)")
    }
}
