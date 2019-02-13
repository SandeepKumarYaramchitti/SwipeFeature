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

struct CardViewModel {
    // We will define properies that are view will display / render out
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
}


