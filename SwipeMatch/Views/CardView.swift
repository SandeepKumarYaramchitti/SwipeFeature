//
//  CardView.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 2/6/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import UIKit

class CardView: UIView {
  
    
    var cardViewModel: CardViewModel! {
        didSet{
            
            //Accessing Index 0 will crash if imageNames.count == 0
            let imageName = cardViewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = UIColor(white: 0, alpha: 0.1)
                barStackView.addArrangedSubview(barView)
            }
            
            barStackView.arrangedSubviews.first?.backgroundColor = UIColor.white
            
            setUPimageIndexObserver()
        }
    }
    
    fileprivate func setUPimageIndexObserver() {
        cardViewModel.imageIndexObserver = { [unowned self] (idx, image) in
            print("Changing photo from view model")
            self.imageView.image = image
            
            self.barStackView.arrangedSubviews.forEach({ (v) in
                
                v.backgroundColor = UIColor(white: 0, alpha: 0.1)
            })
            
            
            self.barStackView.arrangedSubviews[idx].backgroundColor = UIColor.white
        }
    }
    
    fileprivate  let imageView = UIImageView(image: #imageLiteral(resourceName: "Nature").withRenderingMode(.alwaysOriginal))
    fileprivate  let informationLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayouts()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
//    var imageIndex = 0
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        print("Hanlding tap and cycle photos")
        let tapLocations = gesture.location(in: nil)
        let shouldAdvance = tapLocations.x > frame.width / 2 ? true: false
        if shouldAdvance {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
        
        
//        if shouldAdvance {
//            //imageIndex = imageIndex + 1
//            imageIndex = min(imageIndex+1, cardViewModel.imageNames.count - 1)
//        }else {
//            imageIndex = max(0, imageIndex - 1)
//        }
//
//        let imageName = cardViewModel.imageNames[imageIndex]
//        imageView.image = UIImage(named: imageName)
//        barStackView.arrangedSubviews.forEach { (v) in
//            v.backgroundColor = UIColor(white: 0, alpha: 0.1)
//        }
//        barStackView.arrangedSubviews[imageIndex].backgroundColor = UIColor.white
        
    }
    
    let gradientLayer = CAGradientLayer()
    fileprivate func setUpGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    fileprivate func setUpLayouts() {
        //backgroundColor = UIColor.red
        layer.cornerRadius = 10
        clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        setUpBarStackView()
        setUpGradientLayer()
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        informationLabel.textColor = UIColor.white
        informationLabel.numberOfLines = 0
        informationLabel.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
    }
    
    fileprivate let barStackView = UIStackView()
    fileprivate func setUpBarStackView() {
        
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
    
    }
    
    @objc fileprivate func handlePanGesture(gesture: UIPanGestureRecognizer) {
        print("123")
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        //Slide in both directions -
        let tranlationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        
        let threashold: CGFloat = 80
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threashold
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if (shouldDismissCard) {
                self.frame = CGRect(x: 600 * tranlationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            }else {
              self.transform = .identity
            }
            
        }) { (_) in
            self.transform = .identity
            if (shouldDismissCard) {
              self.removeFromSuperview()
            }
            
//            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: nil)
        let degrees: CGFloat = translation.x / 20  //This is to slow down the translation
        let angles = degrees * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angles)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
