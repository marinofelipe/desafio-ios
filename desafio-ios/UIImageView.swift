//
//  UIImageView.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/27/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func load(stringUrl: String) {
        let url = NSURL(string: stringUrl)
        self.af_setImage(withURL: url as! URL, placeholderImage: UIImage(named: "avatarPlaceholder"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false, completion: nil)
    }
    
}
