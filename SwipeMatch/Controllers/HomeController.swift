//
//  ViewController.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 1/26/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    //Top Stack View
    let topStackView = TopNavigationStackView()
    //Main View
    let cardDeckView = UIView()
    //Buttons Stack View
    let buttonsStackView = HomeBottomControlersStackView()
    let cardViewModels = ([
        User(name: "Wedding Day", age: 30, profession: "Marriage", imageNames: ["Wedding1", "Wedding2", "image2"]),
        User(name: "Friends", age: 30, profession: "GOA Trip", imageNames: ["Friends", "Friends2"]),
        Advertise(title: "Slide Out Menu", brand: "Sandeep's App", posterImageName: "image2")
        ] as [ProducesCardViewModel]).map { (producer) -> CardViewModel in
            return producer.toCardViewModel()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        setUpLayOuts()
        setUpDummyCards()
    }
    
    @objc func handleSettings() {
        print("Show Registration page..")
        
        let registrationController = RegistrationController()
        present(registrationController, animated: true)
        
    }
    
    
    
    fileprivate func setUpDummyCards() {
        
        cardViewModels.forEach { (cardViewModels) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardViewModels
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
    
        }
    }
        
    
    // MARK:- Fileprivate
    fileprivate func setUpLayOuts() {
        //Overall StackView
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.frame = .init(x: 0, y: 0, width: 300, height: 300)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardDeckView)
        
    }




}
