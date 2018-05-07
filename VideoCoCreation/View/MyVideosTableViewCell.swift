//
//  MyVideosTableViewCell.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit

class MyVideosTableViewCell: UITableViewCell {

    private var titleLabel = UILabel()
    private var videoImageView = UIImageView()
    private var videoDescription = UITextView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupLayout(){
        
        addSubview(titleLabel)
        addSubview(videoImageView)
        addSubview(videoDescription)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: frame.size.height / 6).isActive = true
        
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        videoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        videoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        videoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        
        videoDescription.translatesAutoresizingMaskIntoConstraints = false
        videoDescription.topAnchor.constraint(equalTo: videoImageView.bottomAnchor, constant: 10).isActive = true
        videoDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        videoDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        videoDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
}
