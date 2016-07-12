//
//  MovieListAction.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/11/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import Social
import Realm
import RealmSwift

extension MovieList {
    
    func share() {
        
        let alert = UIAlertController(title: "", message: "Share your favourite movies", preferredStyle: .ActionSheet)
        let shareFb = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.Default) { (action) in
            
            self.shareFacebook()
        }
        
        let shareTwitter = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.Default) { (action) in
            
            self.shareTwitter()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(shareFb)
        alert.addAction(shareTwitter)
        alert.addAction(cancel)
        presentController!(controller: alert)
    }
    
    func shareFacebook() {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Share on Facebook")
            self.presentController!(controller: facebookSheet)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentController!(controller: alert)
        }
    }
    
    func shareTwitter() {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Share on Twitter")
            presentController!(controller: twitterSheet)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentController!(controller: alert)
        }
    }
    
    func markFavourite(rowIndex: Int, movieCell: MovieTableCell) {
        
        var favourite = false
        let movie = self.movies[rowIndex]
        
        let realm = try! Realm()
        let array = favouriteList.filter("id = \(movie.id!)")
        if array.count > 0 {
            
            for item in array {
                try! realm.write {
                    realm.delete(item)
                }
            }
        }
        else {
            try! realm.write {
                realm.add(FavouriteMovie(id: movie.id!))
            }
            favourite = true 
        }
        movie.favourite = favourite
        movieCell.loveIcon.hidden = false
        animateFavouriteIcon(movieCell.loveIcon, show: favourite)
    }

    func isFavouriteMovie(movieId: Int) -> Bool {
        return favouriteList.filter("id = \(movieId)").count > 0
    }
    
    func animateFavouriteIcon(icon: UIImageView, show: Bool) {
        
        icon.transform = CGAffineTransformMakeScale(0.1, 0.1)
        icon.alpha = show ? 1 : 0
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity:32, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            
            icon.transform = CGAffineTransformIdentity
            }, completion: nil)
        
    }
}