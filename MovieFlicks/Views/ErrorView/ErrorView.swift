//
//  ErrorView.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class ErrorView: KViewBase {

    static let errorTag = 10
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!

    convenience init(frame: CGRect, message: String) {
        self.init(frame: frame)
        messageLabel.text = message
    }
}
