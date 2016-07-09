//
//  Supporter.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import Whisper
import PKHUD

extension UIViewController {
    
    func showErrorViewWithMessage(message: String, present: Bool = false) {
        
        if let navigationController = navigationController {
            let whisper = Message(title: message, textColor: UIColor.whiteColor(), backgroundColor: UIColor.darkGrayColor(), images: nil)
            Whisper(whisper, to: navigationController, action: present ? .Present : .Show)
        }   
    }
    
    func hideErrorView() {
        
        if let navigationController = navigationController {
            Silent(navigationController)
        }
    }
    
    func showLoading(show: Bool) {
        show ?
            HUD.show(.Progress) :
            HUD.hide()
    }
}

extension UIView {
    
    func removeSelf() {
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.alpha = 0
            }, completion: { (Bool) -> Void in self.removeFromSuperview() })
    }
}

