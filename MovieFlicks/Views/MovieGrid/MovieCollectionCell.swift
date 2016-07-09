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
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    func setup(movie: Movie) {
        guard let poster = movie.poster else {
            posterImageView.image = UIImage(named: posterPlaceHolderName)
            return
        }
        
        posterImageView.kf_showIndicatorWhenLoading = true
        posterImageView.downloadImageWithUrlString("\(largePoster)\(poster)")
    }
    
    func showLoading(show: Bool) {
        
        if show {
            
            posterImageView.image = UIImage(named: posterPlaceHolderName)
            loadingView.hidesWhenStopped = true
            loadingView.startAnimating()
        }
        else {
            loadingView.stopAnimating()
        }
    }
    
}
