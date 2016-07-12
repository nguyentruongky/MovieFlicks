//
//  MovieTableCell.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class MovieTableCell: MGSwipeTableCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    @IBOutlet weak var imageLoading: UIActivityIndicatorView!
    @IBOutlet weak var titleLoadingView: UIView!
    @IBOutlet weak var titleLoading: UIActivityIndicatorView!
    @IBOutlet weak var overviewLoading: UIActivityIndicatorView!
    
    
    @IBOutlet weak var loveIcon: UIImageView!
    
    func showLoading(show: Bool) {
        
        if show {
            posterImageView.image = UIImage(named: posterPlaceHolderName)
            imageLoading.startAnimating()
            titleLoading.startAnimating()
            overviewLoading.startAnimating()
            imageLoading.hidden = false 
            titleLabel.text = ""
            overviewLabel.text = ""
        }
        else {
            imageLoading.stopAnimating()
            titleLoading.stopAnimating()
            overviewLoading.stopAnimating()
        }
        
        titleLoadingView.hidden = !show
    }
    
    override func prepareForReuse() {
        posterImageView.image = UIImage(named: "broken")
        loveIcon.hidden = false
        loveIcon.image = UIImage()
    }
    
    func setup(movie: Movie) {
        guard let poster = movie.poster else {
            posterImageView.image = UIImage(named: "broken")
            return
        }
        
        loveIcon.hidden = !movie.favourite
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        posterImageView.kf_showIndicatorWhenLoading = true
        posterImageView.downloadImageWithUrlString("\(smallPoster)\(poster)")
    }
}
