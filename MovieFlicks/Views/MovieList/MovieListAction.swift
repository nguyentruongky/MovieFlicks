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
import FirebaseDatabase
import Firebase

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
        
        let movie = self.movies[rowIndex]
        movieCell.loveIcon.hidden = false
        saveFavouriteToFirebase(movie.id!, favourite: !movie.favourite)
        
        animateFavouriteIcon(movieCell.loveIcon, show: !movie.favourite)
    }

    func retrieveDataFromFirebase() {
        favouriteRef.child("anonymous/favourite").observeEventType(.Value, withBlock: { (snapshot: FIRDataSnapshot) in
            
            if snapshot.value != nil && !(snapshot.value is NSNull) {
                let dictionary = snapshot.value as! [String: Bool]
                print(dictionary)
                var favoritedMovieIds = [Int]()
                for (key, value) in dictionary {
                    
                    if value == true {
                        favoritedMovieIds.append(Int(key)!)
                    }
                }
                self.favouriteMovies = favoritedMovieIds
                self.tableView.reloadData()
            }
        })
        
    }

    
    func saveFavouriteToFirebase(movieId: Int, favourite: Bool) {
        
        favouriteRef.child("anonymous/favourite/\(movieId)").setValue(favourite)
    }
    
    
    
    
    func isFavouriteMovie(movieId: Int) -> Bool {
        return favouriteMovies.contains(movieId)
//        return favouriteList.filter("id = \(movieId)").count > 0
    }
    
    func animateFavouriteIcon(icon: UIImageView, show: Bool) {
        
        icon.transform = CGAffineTransformMakeScale(0.1, 0.1)
        icon.alpha = show ? 1 : 0
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity:32, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            
            icon.transform = CGAffineTransformIdentity
            }, completion: nil)
        
    }
}