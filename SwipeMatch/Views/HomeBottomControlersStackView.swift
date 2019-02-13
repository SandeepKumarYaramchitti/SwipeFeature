//
//  HomeBottomControlersStackView.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 1/26/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import UIKit

class HomeBottomControlersStackView: UIStackView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        let subViews = [#imageLiteral(resourceName: "refresh"), #imageLiteral(resourceName: "nomatch"), #imageLiteral(resourceName: "star"), #imageLiteral(resourceName: "love"), #imageLiteral(resourceName: "profile")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        subViews.forEach { (v) in
            addArrangedSubview(v)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
