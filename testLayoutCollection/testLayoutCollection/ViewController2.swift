//
//  ViewController2.swift
//  testLayoutCollection
//
//  Created by oneweek on 10/12/18.
//  Copyright © 2018 Harry Nguyen. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var imvPhoto : UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let image = TransitionManager.shared.photo {
            self.imvPhoto.image = image
        }
    }
    
    
    @IBAction func selectedDismissButton(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }

}
