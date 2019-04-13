//
//  RegistrationViewModel.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 3/9/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    
    var fullName: String? {
        didSet{
           checkFormValidity()
        }
    }
    var email: String?{
        didSet{
           checkFormValidity()
        }
    }
    var password: String?{
        didSet{
           checkFormValidity()
        }
    }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
       
        guard let email = email, let password = password else {return}
         bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            
            if let err = err {
                completion(err)
                return
            }
            
            print("Successfully registered user:", res?.user.uid ?? "")
            // Only upload when user is authorized
            
            let fileName = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
            
            let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            
            ref.putData(imageData, metadata: nil, completion: { (_, err) in
                
                if let err = err {
                    completion(err)
                    return
                }
                
                print("Finished uploading image to storage....")
                ref.downloadURL(completion: { (url, err) in
                    
                    if let err = err {
                        completion(err)
                        return
                    }
                    
                    self.bindableIsRegistering.value = false
                    print("Downloaded URL:", url?.absoluteString ?? "")
                    // Store the download url into Firestore
                    
                })
                
            })
            
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    //Reactive Programming
    // 1. Define the observer
    // 2. check for fields to change for state with didSet
    
    var bindableIsFormValid = Bindable<Bool>()
    
//    var isFormObserver: ((Bool) -> ())?
}

