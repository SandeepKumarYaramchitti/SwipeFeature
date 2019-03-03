//
//  RegistrationController.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 3/1/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    //UI Components
    
    let selectPhoto: UIButton = {
       
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullName: customTextField = {
       let tf = customTextField(padding: 16)
       tf.placeholder = "Enter Full Text"
        tf.backgroundColor = UIColor.white
       return tf
        
    }()
    
    let emailTextField: customTextField = {
       let tf = customTextField(padding: 16)
       tf.placeholder = "Enter email address"
       tf.keyboardType = .emailAddress
       tf.backgroundColor = UIColor.white
       return tf
    }()
    
    let passwordField: customTextField = {
       let tf = customTextField(padding: 16)
       tf.placeholder = "Enter Password"
       tf.isSecureTextEntry = true
       tf.backgroundColor = UIColor.white
       return tf
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = UIColor.blue
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        setUpGradientLayer()
        setUpLayout()
        setUpnotificationObserver()
        setUpTapGesture()

    }
    
    func setUpTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc func handleTapDismiss() {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
             self.view.transform = .identity
        })
        
    }
    
     func setUpnotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self) //This is very important to remove the Notification center instance when view is deleted
        
    }
    
    @objc func handleKeyboardHide() {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = value.cgRectValue
        print(keyboardFrame)
        //Find out height of the stackview
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        print(bottomSpace)
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    
        
    }
    
    fileprivate func setUpGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = UIColor.black
        let bottomColor = UIColor.red
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 0.5]
        gradientLayer.frame = view.frame
        view.layer.addSublayer(gradientLayer)
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        selectPhoto, fullName, emailTextField, passwordField, registerButton
        ])
    
    fileprivate func setUpLayout() {
        
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}










