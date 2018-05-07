//
//  CreateVideoViewController.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit

class CreateVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
        setupLayout()
        
    }

    
    func setupLayout(){
        self.title = "Create a video!"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .cyan
    }
}
