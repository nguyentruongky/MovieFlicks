//
//  MovieCollectionCell.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    func setup(movie: Movie) {
        guard let poster = movie.poster else {
            posterImageView.image = UIImage(named: "broken")
            return
        }
        
        posterImageView.kf_showIndicatorWhenLoading = true
        posterImageView.downloadImageWithUrlString(poster)
    }
    
}
