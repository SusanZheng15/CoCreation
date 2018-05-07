//
//  MyVideosViewController.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit

class MyVideosViewController: UIViewController {

    private var videoTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    func setupLayout(){
        let navBar = self.navigationController?.navigationBar
        self.title = "My Video"
        self.view.backgroundColor = .white
        navBar?.isTranslucent = false
        navBar?.barTintColor = .green
      
        view.addSubview(videoTableView)
        
        videoTableView.backgroundColor = .purple
        videoTableView.translatesAutoresizingMaskIntoConstraints = false
        videoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        videoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        videoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        videoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
    }

}
