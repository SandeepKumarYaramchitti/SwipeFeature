//
//  CardViewModel.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 2/10/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import Foundation
import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    // We will define properies that are view will display / render out
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageName = imageNames[imageIndex]
            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex,image ?? UIImage())
        }
    }
    
    //Reactive Programming
    var imageIndexObserver: ((Int, UIImage) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
     func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
    
    
    
}


