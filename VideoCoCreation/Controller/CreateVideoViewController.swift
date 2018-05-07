//
//  CreateVideoViewController.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation

class CreateVideoViewController: UIViewController {

    private var coCreationView = CoCreationView()
    private var languagePickerView = UIPickerView()
    var imageData: Data?
    var videoData: Data?
    var languageID: Int?
    var tempVideoOutput: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        setupLayout()
        coCreationView.delegate = self
    }

    
    func setupLayout(){
        self.title = "Create a video!"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        
        coCreationView.descriptionTextView.delegate = self
        
        coCreationView.languageTextField.inputView = languagePickerView
        view.addSubview(coCreationView)
        
        if videoData == nil{
            coCreationView.playButtonView.isHidden = true
            coCreationView.removeVideoButton.isHidden = true
            coCreationView.uploadVideoButton.isHidden = false
            coCreationView.submitButton.isHidden = true
        }else{
            coCreationView.removeVideoButton.isHidden = false
            coCreationView.playButtonView.isHidden = false
            coCreationView.uploadVideoButton.isHidden = true
            coCreationView.submitButton.isHidden = false
        }
        coCreationView.translatesAutoresizingMaskIntoConstraints = false
        coCreationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        coCreationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        coCreationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        coCreationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func getLanguageStrings()->[String]{
        return ["English", "Spanish"]
    }
    
    func getLanguageIDs()->[Int]{
        return [1, 2]
    }
    
    func pickMediaSourceAlert(){
        let actionSheet = UIAlertController(title: "Pick your image", message: "Pick image source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            self.getToCameraRoll()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Media Library", style: .default, handler: { (action: UIAlertAction) in
            self.goToPhotoLibraryForPhoto()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//        actionSheet.popoverPresentationController?.sourceView = self.chooseVideoOutlet
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func pickVideoMediaSourceAlert(){
        let actionSheet = UIAlertController(title: "Pick a video source", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            self.goToCameraViaVideo()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Media Library", style: .default, handler: { (action: UIAlertAction) in
            self.goToPhotoLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//        actionSheet.popoverPresentationController?.sourceView = self.chooseVideoOutlet
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func removeImageAlert(){
        let actionSheet = UIAlertController(title: "Do you want to remove the current image?", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "No, Keep my image", style: .default, handler: { (action: UIAlertAction) in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Yes, remove my image", style: .destructive, handler: { (action:UIAlertAction) in
            self.imageData = nil
            self.coCreationView.setImage(image: #imageLiteral(resourceName: "backimage"))
            self.coCreationView.pickImageTitle.isHidden = false
            self.pickMediaSourceAlert()
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func goToPhotoLibraryForPhoto(){
        let mediaPicker = UIImagePickerController()
        
        mediaPicker.delegate = self
        
        mediaPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        mediaPicker.allowsEditing = false
        
        self.present(mediaPicker, animated: true, completion: nil)
    }
    func getToCameraRoll(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let mediaPicker = UIImagePickerController()
            
            mediaPicker.delegate = self
            
            mediaPicker.sourceType = UIImagePickerControllerSourceType.camera
            
            self.present(mediaPicker, animated: true, completion: nil)
        }
    }
    
    func goToPhotoLibrary(){
        let mediaPicker = UIImagePickerController()
        
        mediaPicker.delegate = self
        mediaPicker.mediaTypes = ["public.movie"]
        
        
        mediaPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        mediaPicker.allowsEditing = false
        
        self.present(mediaPicker, animated: true, completion: nil)
    }
    
    func goToCameraViaVideo(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            let mediaPicker = UIImagePickerController()
            
            mediaPicker.sourceType = .camera
            mediaPicker.mediaTypes = [kUTTypeMovie as String]
            mediaPicker.allowsEditing = false
            
            mediaPicker.delegate = self
            
            self.present(mediaPicker, animated: true, completion: nil)
            
        }else{
            print("why u no work?")
            
        }
    }
    
    func didTapSubmit(){
        guard let title = coCreationView.titleTextField.text else {return}
        guard let description = coCreationView.descriptionTextView.text else {return}
        
        if title == "" || title.isReallyEmpty == true || description == "" || description.isReallyEmpty == true || languageID == nil || imageData == nil{
            let errorAlert = UIAlertController(title: "Error",
                                               message: "Please be sure to fill all the fields",
                                               preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }else{
            let data = try? Data(contentsOf: self.tempVideoOutput!)
            print("File size before compression: \(Double((data?.count)! / 1048576)) mb")
            let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".m4v")
            compressVideo(inputURL: self.tempVideoOutput!, outputURL: compressedURL) { (exportSession) in
                guard let session = exportSession else {return}
                
                switch session.status{
                    
                case .unknown:
                    break
                case .waiting:
                    break
                case .exporting:
                    break
                case .completed:
                    guard let compressedData = try? Data(contentsOf: compressedURL) else {return}
                    
                    print("File size after compression: \(Double(compressedData.count / 1048576)) mb")
                    MyResourcesService.uploadVideo(title: title, description: description, type: 6, language: self.languageID!, videoData: compressedData, imageData: self.imageData!) { (result) in
                        if result.isSuccess{
                            print("success")
                            DispatchQueue.main.async(execute: {
                            
                                let successAlert = UIAlertController(title: "Upload complete!",
                                                                     message: "Your video has been successfully uploaded",
                                                                     preferredStyle: .alert)
                                
                                let okay = UIAlertAction.init(title: "Okay", style: .default, handler: { (alert) in
                                })
                                successAlert.addAction(okay)
                                self.present(successAlert, animated: true, completion: nil)
                            })
                        }else if result.isFailure{
                            print("failed")
                    
                            DispatchQueue.main.async(execute: {
                                let errorAlert = UIAlertController(title: "Error",
                                                                   message: "NETWORK_ISSUE._PLEASE_TRY_LATER",
                                                                   preferredStyle: .alert)
                                errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                
                                self.present(errorAlert, animated: true, completion: nil)
                            })
                        }
                    }
                case .failed:
                    break
                case .cancelled:
                    break
                }
            }
        }
    }
    
    func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetMediumQuality) else {
            handler(nil)
            
            return
        }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = kUTTypeQuickTimeMovie as AVFileType
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously { () -> Void in
            handler(exportSession)
        }
    }
    
}

extension CreateVideoViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getLanguageStrings().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return getLanguageStrings()[row]
    }
}

extension CreateVideoViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.languageID = getLanguageIDs()[row]
        coCreationView.languageTextField.text = getLanguageStrings()[row]
    }
}

extension CreateVideoViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter description here" || textView.text.isReallyEmpty{
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isReallyEmpty{
            textView.text = "Enter description here"
        }
    }
}

extension CreateVideoViewController: CoCreationViewDelegate{
    func didTapPlayVideo() {
        if let url = self.tempVideoOutput{
            let videoPlayerView = AVPlayerViewController()
            let player = AVPlayer.init(url: url)
            videoPlayerView.player = player
            self.present(videoPlayerView, animated: true) {
                videoPlayerView.player!.play()
            }
        }
    }
    
    func didTapRemoveVideo() {
        let alert = UIAlertController(title: "Do you want to remove your current video?",
                                                 message: "",
                                                 preferredStyle: .alert)
        let no = UIAlertAction.init(title: "No, keep video", style: .default) { (no) in
        }
        let remove = UIAlertAction.init(title: "Yes, remove video", style: .destructive) { (remove) in
            self.videoData = nil
            self.coCreationView.playButtonView.isHidden = true
            self.coCreationView.removeVideoButton.isHidden = true
            self.coCreationView.uploadVideoButton.isHidden = false
            self.coCreationView.submitButton.isHidden = true
        }
        alert.addAction(no)
        alert.addAction(remove)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func didTapAddImage() {
        if imageData == nil{
            pickMediaSourceAlert()
        }else{
            removeImageAlert()
        }
        
    }
    
    func didTapUploadVideo() {
        pickVideoMediaSourceAlert()
    }
    
    func didTapSubmitVideo(){
        self.didTapSubmit()
    }
}

extension CreateVideoViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.imageData = UIImageJPEGRepresentation(image, 0.5)
            self.coCreationView.pickImageTitle.isHidden = true
            self.coCreationView.setImage(image: image)
        }

        if let videoPath =  info[UIImagePickerControllerMediaURL] as? URL{
            let tempVideoUrl = videoPath
            self.tempVideoOutput = tempVideoUrl
            self.videoData = try? Data(contentsOf: tempVideoUrl)
            coCreationView.playButtonView.isHidden = false
            coCreationView.removeVideoButton.isHidden = false
            coCreationView.uploadVideoButton.isHidden = true
            coCreationView.submitButton.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CreateVideoViewController: UINavigationControllerDelegate{}
