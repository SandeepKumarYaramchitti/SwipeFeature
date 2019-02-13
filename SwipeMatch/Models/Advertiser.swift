//
//  Advertiser.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 2/10/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import Foundation
import UIKit

struct Advertise: ProducesCardViewModel {
    let title: String
    let brand: String
    let posterImageName: String
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [.font : UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "  \n" + brand, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
 
        return CardViewModel(imageNames: [posterImageName], attributedString: attributedText, textAlignment: .center)
    }
}

//Advertise(title: <#T##String#>, brand: <#T##String#>, posterImageName: <#T##String#>)
