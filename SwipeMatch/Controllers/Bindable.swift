//
//  Bindable.swift
//  SwipeMatch
//
//  Created by Sandeep Kumar  Yaramchitti on 3/13/19.
//  Copyright © 2019 Sandeep Kumar  Yaramchitti. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
