//
//  TransitionManager.swift
//  testTransition3
//
//  Created by oneweek on 5/12/17.
//  Copyright © 2017 Harry Nguyen. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    
    
    static let shared: TransitionManager = {
        var instance = TransitionManager()
        // setup code
        
        return instance
    }()
    
    let animatorOverOut = TransitionPushViewController()
    let animatorOverIn = TransitionPopViewController()
    
    
    var photo : UIImage?
    
    override init() {
        super.init()
    }
    
    
    
}
