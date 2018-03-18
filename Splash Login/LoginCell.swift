//
//  LoginCell.swift
//  Splash Login
//
//  Created by Sieder Villareal on 3/15/18.
//  Copyright © 2018 Sieder Villareal. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageV = UIImageView(image: image)
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    let emailTextField: LeffPaddedTextField = {
        let tf = LeffPaddedTextField()
        tf.placeholder = "Enter email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let passwordTextField: LeffPaddedTextField = {
        let tf = LeffPaddedTextField()
        tf.placeholder = "Enter password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        //[NSColor colorWithCalibratedRed:0.93 green:0.62 blue:0.22 alpha:1.00]
        button.backgroundColor = UIColor(red: 0.93, green: 0.62, blue: 0.22, alpha: 1)
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        logoImageView.topAnchor.constraint(equalTo: centerYAnchor, constant: -230).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 32).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -32).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 32).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -32).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8).isActive = true
        loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 32).isActive = true
        loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -32).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LeffPaddedTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width  + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width  + 10, height: bounds.height)
    }
}

















