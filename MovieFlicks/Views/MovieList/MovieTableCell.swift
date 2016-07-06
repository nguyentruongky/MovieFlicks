//
//  MovieTableCell.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MovieTableCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    func setup(movie: Movie) {
        guard let poster = movie.poster else {
            posterImageView.image = UIImage(named: "broken")
            return
        }
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        posterImageView.kf_showIndicatorWhenLoading = true
        posterImageView.downloadImageWithUrlString("\(largePoster)\(poster)")
    }
}
