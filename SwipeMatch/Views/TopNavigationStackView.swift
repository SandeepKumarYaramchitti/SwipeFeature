//
//  TopNavigationStackView.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 2/3/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let fileImageView = UIImageView(image: #imageLiteral(resourceName: "hot"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fileImageView.contentMode = .scaleAspectFit
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        settingsButton.setImage(#imageLiteral(resourceName: "user").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "message").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingsButton, UIView(), fileImageView, UIView(), messageButton].forEach { (v) in
            addArrangedSubview(v)
        }
        
        distribution = .equalCentering
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        subviews.forEach { (v) in
            addArrangedSubview(v)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
