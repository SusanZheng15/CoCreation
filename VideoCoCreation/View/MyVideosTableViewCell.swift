//
//  MyVideosTableViewCell.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit
import SDWebImage

class MyVideosTableViewCell: UITableViewCell {

    var titleLabel = UILabel()
    var videoImageView = UIImageView()
    var videoDescription = UITextView()
    var creatorImageView = UIImageView()
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }

   
    func setupLayout(){
        
        addSubview(titleLabel)
        addSubview(videoImageView)
        addSubview(videoDescription)
        addSubview(creatorImageView)
        
        self.backgroundColor = UIColor(red:0.19, green:0.16, blue:0.15, alpha:1.0)
        
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        videoImageView.contentMode = .scaleAspectFill
        videoImageView.clipsToBounds = true
        videoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        videoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        videoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        
        creatorImageView.translatesAutoresizingMaskIntoConstraints = false
        creatorImageView.contentMode = .scaleToFill
        creatorImageView.topAnchor.constraint(equalTo: videoImageView.bottomAnchor, constant: 10).isActive = true
        creatorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        creatorImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        creatorImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.topAnchor.constraint(equalTo: videoImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: creatorImageView.trailingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: frame.size.height / 8).isActive = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.frame.size.height * 0.5)
        
        videoDescription.translatesAutoresizingMaskIntoConstraints = false
        videoDescription.isEditable = false
        videoDescription.isScrollEnabled = false
        videoDescription.backgroundColor = .clear
        videoDescription.textColor = .white
        videoDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        videoDescription.leadingAnchor.constraint(equalTo: creatorImageView.trailingAnchor, constant: 10).isActive = true
        videoDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        videoDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
    
    
    func setValue(resource: GeniusResource){
        
        titleLabel.text = resource.getTitle()
        if let url = URL(string: resource.getResourceImageURL()){
            videoImageView.sd_setImage(with: url, completed: nil)
        }else{}
        videoDescription.text = resource.getDescriptionString()
        
        if let url = URL(string: resource.getCreatorAvatarURLString()){
            creatorImageView.sd_setImage(with: url, completed: nil)
        }
        
    }
    
}
