//
//  Communicator.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

struct Communicator {
    
    static func get(api: String, params: [String: AnyObject]?, successCompletion: (rawData: AnyObject) -> Void, failCompletion: ((message: String) -> Void)?) {
        
        var parameters = params == nil ? [String: AnyObject]() : params!
        parameters["api_key"] = apiKey
        
        Alamofire.request(.GET, api, parameters: parameters)
            .responseJSON { response in
                guard let rawData = response.result.value else { failCompletion?(message: "fail"); return }
                successCompletion(rawData: rawData)
        }
    }
}

extension UIImageView {
    
    func downloadImageWithUrlString(urlString: String) {
        
        let url = NSURL(string: urlString)
        self.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "broken"))
    }
}