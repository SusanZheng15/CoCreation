//
//  MyVideosViewController.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit
import AVKit

class MyVideosViewController: UIViewController {

    private var videoTableView = UITableView()
    private var myResourceArray: [GeniusResource] = []
    private var pageNumber = 1
    private var resourceCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        getData()
    }
    
    func setupLayout(){
        let navBar = self.navigationController?.navigationBar
        self.title = "My Video"
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
       
        self.view.backgroundColor = .darkGray
        navBar?.isTranslucent = true
        navBar?.barTintColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
      
        view.addSubview(videoTableView)
       
        videoTableView.register(MyVideosTableViewCell.self, forCellReuseIdentifier: "cell")
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.backgroundColor = .clear
        videoTableView.translatesAutoresizingMaskIntoConstraints = false
        videoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        videoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        videoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        videoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func getData(){
        self.videoTableView.isHidden = true
        MyResourcesService.getMyVideosResource(search: "", types: "video", language: 1, my_resources: true, page_number: pageNumber, gid: 0, favorites: false, is_vr: false, careers: false) { (data, count) in
            DispatchQueue.main.async(execute: {
                self.myResourceArray = data
                self.resourceCount = count
                self.videoTableView.isHidden = false
                self.videoTableView.reloadData()
            })
            
        }
    }
    
    @objc func didTapOnResource(sender: UITapGestureRecognizer){
        print(self.myResourceArray[(sender.view?.tag)!].getResourceID())
        MyResourcesService.getResourceDetail(resourceID: self.myResourceArray[(sender.view?.tag)!].getResourceID()) { (detail) in
            DispatchQueue.main.async(execute: {
                if let urlString = detail.video_url{
                    if let url = URL(string: urlString){
                        let playerController = AVPlayerViewController()
                        let player = AVPlayer.init(url: url)
                        playerController.player = player
                        self.present(playerController, animated: true, completion: {
                            playerController.player?.play()
                        })
                    }
                }
                
            })
        }
    }

}

extension MyVideosViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myResourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyVideosTableViewCell
        cell.selectionStyle = .none
        
        cell.setValue(resource: self.myResourceArray[indexPath.row])
        
        cell.videoImageView.isUserInteractionEnabled = true
        cell.videoImageView.tag = indexPath.row
        let imageGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.didTapOnResource(sender:)))
        cell.videoImageView.addGestureRecognizer(imageGesture)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.videoTableView.frame.size.height * 0.4
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
            if myResourceArray.count < resourceCount{
                pageNumber += 1
                MyResourcesService.getMyVideosResource(search: "", types: "video", language: 1, my_resources: true, page_number: pageNumber, gid: 0, favorites: false, is_vr: false, careers: false) { (data, count) in
                    DispatchQueue.main.async(execute: {
                        self.myResourceArray.append(contentsOf: data)
                        self.videoTableView.reloadData()
                    })
                }
            }
           
        }
    }
}

extension MyVideosViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    
}

