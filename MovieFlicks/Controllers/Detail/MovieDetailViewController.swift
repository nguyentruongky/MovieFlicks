//
//  MovieDetailViewController.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewScrollView: UIScrollView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    var data: Movie!
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = data.title
        titleLabel.text = data.title
        dateLabel.text = data.releaseDate
        rateLabel.text = String(data.voteAverage!)
        overviewLabel.text = data.overview!
        posterImageView.downloadImageWithUrlString("\(largePoster)\(data.poster!)")
        
        scrollView.delegate = self
        contentViewHeight.constant = UIScreen.mainScreen().bounds.height
        overviewScrollView.scrollEnabled = false
        
        MovieDetailCommunication.getDetailWithMovieId(data.id!, successHandler: { (runTime) in
            let h = runTime / 60
            let m = runTime % 60
            let min = m % 60 == 0 ? "" : "\(m) mins"
            self.timeLabel.text = "\(h) hr \(min)"
            }, failHandler: nil)
    }
    
    

}
