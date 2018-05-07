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
        self.tabBar.barTintColor = UIColor(red:0.19, green:0.16, blue:0.15, alpha:1.0)
//        self.tabBar.barTintColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)

        let vc = UINavigationController(rootViewController: CreateVideoViewController())
        vc.tabBarItem.title = "Create Video"
        vc.tabBarItem.image = #imageLiteral(resourceName: "plus")
       
        
        let vc2 = UINavigationController(rootViewController: MyVideosViewController())
        vc2.tabBarItem.title = "My Video"
        vc2.tabBarItem.image = #imageLiteral(resourceName: "video")
        viewControllers = [vc, vc2]
    }

}

