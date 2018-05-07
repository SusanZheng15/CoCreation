//
//  MainTabBarController.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
      
    }

 

    func setupTabBar(){
        let vc = UINavigationController(rootViewController: CreateVideoViewController())
        vc.tabBarItem.title = "Create Video"
       
        
        let vc2 = UINavigationController(rootViewController: MyVideosViewController())
        vc2.tabBarItem.title = "My Video"
        
        viewControllers = [vc, vc2]
    }

}

