//
//  LoginScreenViewController.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginScreenViewController: UIViewController {

    private var usernameTextField = UITextField()
    private var passwordTextField = UITextField()
    private var loginButton = UIButton()
    private var logo = UIImageView()
    
    let userKeyChain = KeychainSwift()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        
    }

    
    func setupLayout(){
        self.view.backgroundColor = UIColor(red:0.19, green:0.16, blue:0.15, alpha:1.0)
       
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(logo)
        
        setTextFieldAttribute(textField: usernameTextField, placeholder: "Username")
        setTextFieldAttribute(textField: passwordTextField, placeholder: "Password")
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        logo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        logo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        logo.contentMode = .scaleToFill
        logo.clipsToBounds = true
        logo.image = #imageLiteral(resourceName: "Genius-Plaza-transp-logo")
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true

        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        passwordTextField.isSecureTextEntry = true

        
        setButtonAttribute(button: loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        loginButton.addTarget(self, action: #selector(self.didTapLogin(sender:)), for: .touchUpInside)
    }
    
    func setTextFieldAttribute(textField: UITextField, placeholder: String){
    
        textField.layer.cornerRadius = 5
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.backgroundColor = .white
        textField.autocorrectionType = .no
        textField.placeholder = placeholder
    }
    
    func setButtonAttribute(button: UIButton){
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        button.layer.cornerRadius = 10
    }

    @objc func didTapLogin(sender: UIButton){
        self.view.endEditing(true)
        
        if self.checkForMissingParameters(fields: [usernameTextField, passwordTextField], textViewPlaceholder: nil, requiredData: nil).contains(true){
                //
        }else{
            Animation.sharedInstance.bounceButtonAnimation(for: sender, completion: {})
            guard let username = usernameTextField.text else {return}
            guard let password = passwordTextField.text else {return}
            
            let lowerCasedPassword = password.lowercased()
            
            LoginNetwork.getAccessToken(username: username, password: lowerCasedPassword) { (accessToken) in
                OperationQueue.main.addOperation({
                    if accessToken != "" {
                        self.userKeyChain.set(accessToken, forKey:"accessToken")
                        let vc = MainTabBarController()
                        self.present(vc, animated: true, completion: nil)
                    } else{
                        self.shakeMultipleViews(fields: [self.usernameTextField, self.passwordTextField])
                        self.alert(message: "Login Credentials Invalid")
                    }
                })
            }
        }
       
    }
    
}
