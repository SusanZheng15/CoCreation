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

    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var loginButton = UIButton()
    
    let userKeyChain = KeychainSwift()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        
    }

    
    func setupLayout(){
        view.backgroundColor = .white
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        setTextFieldAttribute(textField: loginTextField, placeholder: "Username")
        setTextFieldAttribute(textField: passwordTextField, placeholder: "Password")
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30).isActive = true
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
       // textField.font = UIFont(
     //   textField.font = UIFont.init(name: "AvenirNext-Medium", size: textField.frame.size.height / 2)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        textField.autocorrectionType = .no
        textField.placeholder = placeholder
    }
    
    func setButtonAttribute(button: UIButton){
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 10
    }
    
    
    @objc func didTapLogin(sender: UIButton){
        Animation.sharedInstance.bounceButtonAnimation(for: sender, completion: {})
        guard let username = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let lowerCasedPassword = password.lowercased()
        self.view.endEditing(true)
      
        LoginServer.getAccessToken(username: username, password: lowerCasedPassword) { (accessToken) in
            OperationQueue.main.addOperation({
                if accessToken != "" {
                    self.userKeyChain.set(accessToken, forKey:"accessToken")
                    let vc = MainTabBarController()
                    self.present(vc, animated: true, completion: nil)
                } else{
                    self.alert(message: "Login Credentials Invalid")
                }
            })
        }
    }
    
}
