//
//  User.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 2/10/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import Foundation
import UIKit

struct User: ProducesCardViewModel {
    let name: String
    let age: Int
    let profession: String
    let imageNames: [String]
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "  \(profession)", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .regular)]))
        
        return CardViewModel(imageNames: imageNames, attributedString: attributedText, textAlignment: .left)
    }
}


