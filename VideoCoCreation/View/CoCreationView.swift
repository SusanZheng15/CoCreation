//
//  CoCreationView.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit

protocol CoCreationViewDelegate {
    func didTapAddImage()
    func didTapUploadVideo()
    func didTapPlayVideo()
    func didTapRemoveVideo()
    func didTapSubmitVideo()
}
class CoCreationView: UIView {

    var pickImageTitle = UILabel()
    var imageView = UIImageView()
    var titleTextField = UITextField()
    var languageTextField = UITextField()
    var descriptionTextView = UITextView()
    var uploadVideoButton = UIButton()
    var submitButton = UIButton()
    var playButtonView = UIImageView()
    var removeVideoButton = UIButton()
    var delegate: CoCreationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout(){
        self.backgroundColor = UIColor(red:0.19, green:0.16, blue:0.15, alpha:1.0)
        
        addSubview(imageView)
        addSubview(titleTextField)
        addSubview(pickImageTitle)
        addSubview(languageTextField)
        addSubview(descriptionTextView)
        addSubview(uploadVideoButton)
        addSubview(playButtonView)
        addSubview(removeVideoButton)
        addSubview(submitButton)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.didTapOnImage(sender:)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        imageView.image = #imageLiteral(resourceName: "backimage")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        pickImageTitle.translatesAutoresizingMaskIntoConstraints = false
        pickImageTitle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        pickImageTitle.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 0).isActive = true
        pickImageTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        pickImageTitle.widthAnchor.constraint(equalTo: pickImageTitle.widthAnchor).isActive = true
        pickImageTitle.textAlignment = .center
        pickImageTitle.text = "Click here to add image"
        pickImageTitle.textColor = .white
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        titleTextField.backgroundColor = UIColor(red:0.43, green:0.43, blue:0.43, alpha:1.0)
        titleTextField.attributedPlaceholder = NSAttributedString(string:"Enter Title", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        titleTextField.textColor = .white
        titleTextField.textAlignment = .center
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 2).isActive = true
        descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        descriptionTextView.textColor = .white
        descriptionTextView.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        descriptionTextView.backgroundColor = UIColor(red:0.43, green:0.43, blue:0.43, alpha:1.0)
        descriptionTextView.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 18)
        descriptionTextView.text = "Enter description here"
        descriptionTextView.textAlignment = .center
        
        languageTextField.translatesAutoresizingMaskIntoConstraints = false
        languageTextField.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 2).isActive = true
        languageTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        languageTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        languageTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        languageTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        languageTextField.backgroundColor = UIColor(red:0.43, green:0.43, blue:0.43, alpha:1.0)
      
        languageTextField.attributedPlaceholder = NSAttributedString(string:"Pick a Language", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        languageTextField.textColor = .white
        languageTextField.textAlignment = .center
        
        uploadVideoButton.translatesAutoresizingMaskIntoConstraints = false
        uploadVideoButton.layer.cornerRadius = 10
        uploadVideoButton.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        uploadVideoButton.setTitleColor(UIColor.white, for: .normal)
        uploadVideoButton.setTitle("Get Video", for: .normal)
        uploadVideoButton.topAnchor.constraint(equalTo: languageTextField.bottomAnchor, constant: 10).isActive = true
        uploadVideoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        uploadVideoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        uploadVideoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uploadVideoButton.addTarget(self, action: #selector(self.didTapUploadVideo(sender:)), for: .touchUpInside)
        
        playButtonView.translatesAutoresizingMaskIntoConstraints = false
      
        playButtonView.topAnchor.constraint(equalTo: languageTextField.bottomAnchor, constant: 10).isActive = true
        playButtonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        playButtonView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playButtonView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButtonView.image = #imageLiteral(resourceName: "play")
        playButtonView.isUserInteractionEnabled = true
        let playVideoGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.didTapPlayVideo(sender:)))
        playButtonView.addGestureRecognizer(playVideoGesture)
        
        removeVideoButton.translatesAutoresizingMaskIntoConstraints = false
        removeVideoButton.topAnchor.constraint(equalTo: languageTextField.bottomAnchor, constant: 15).isActive = true
        removeVideoButton.leadingAnchor.constraint(equalTo: playButtonView.trailingAnchor, constant: 0).isActive = true
        removeVideoButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        removeVideoButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        removeVideoButton.backgroundColor = .clear
        removeVideoButton.setTitle("Remove", for: .normal)
        removeVideoButton.setTitleColor(.red, for: .normal)
        removeVideoButton.addTarget(self, action: #selector(self.didTapRemoveVideo(sender:)), for: .touchUpInside)
      
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.layer.cornerRadius = 10
        submitButton.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.setTitle("Upload Video", for: .normal)
        submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        submitButton.addTarget(self, action: #selector(self.didTapSubmit(sender:)), for: .touchUpInside)
        
        
    }
    
    @objc func didTapOnImage(sender: UITapGestureRecognizer){
        delegate?.didTapAddImage()
    }
    
    @objc func didTapUploadVideo(sender: UIButton){
        Animation.sharedInstance.bounceButtonAnimation(for: sender, completion: {})
        delegate?.didTapUploadVideo()
    }
    
    @objc func didTapPlayVideo(sender: UITapGestureRecognizer){
        delegate?.didTapPlayVideo()
    }
    
    @objc func didTapRemoveVideo(sender: UIButton){
        delegate?.didTapRemoveVideo()
    }
    
    @objc func didTapSubmit(sender: UIButton){
        Animation.sharedInstance.bounceButtonAnimation(for: sender, completion: {})
        delegate?.didTapSubmitVideo()
    }
    
    func setImage(image: UIImage?){
        imageView.image = image
    }
    
}
