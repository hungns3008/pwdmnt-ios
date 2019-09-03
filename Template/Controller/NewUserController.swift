//
//  NewUserController.swift
//  Template
//
//  Created by Hung Nguyen on 8/26/19.
//  Copyright © 2019 Hung Nguyen. All rights reserved.
//

import UIKit
import IGListKit
import PinLayout

class NewUserController: UIViewController {
    
    var viewModel = NewUserViewModel();
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Account Name"
        return label
    }()
    
    lazy var titleTf: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter account name"
        return tf
    }()
    
    lazy var userLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    
    lazy var userNameTf: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter username"
        return tf
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        return label
    }()
    
    lazy var passwordTf: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: UIControl.State.normal)
        button.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(submit), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(titleLabel)
        view.addSubview(titleTf)
        view.addSubview(userLabel)
        view.addSubview(userNameTf)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTf)
        view.addSubview(submitButton)
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard)))
        
        viewModel.errOb.asObserver().subscribe(onNext: {[weak self] err in
            if let wSelf = self, let error = err {
                let alertController = UIAlertController()
                alertController.message = error
                alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                wSelf.present(alertController, animated: true, completion: nil)
            }
        }).disposed(by: viewModel.disposeBag)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.pin.left().top(view.pin.safeArea.top + 16).right().marginLeft(16).marginRight(16).sizeToFit()
        titleTf.pin.below(of: titleLabel).left().right().marginLeft(16).marginRight(16).marginTop(8).sizeToFit()
        userLabel.pin.below(of: titleTf).left().right().marginLeft(16).marginTop(16).marginRight(16).sizeToFit()
        userNameTf.pin.below(of: userLabel).left().right().marginLeft(16).marginRight(16).marginTop(8).sizeToFit()
        passwordLabel.pin.below(of: userNameTf).left().right().marginLeft(16).marginTop(16).marginRight(16).sizeToFit()
        passwordTf.pin.below(of: passwordLabel).left().right().marginLeft(16).marginRight(16).marginTop(8).sizeToFit()
        layoutSubmitButton(keyboardShowed: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func hideKeyboard() {
        userNameTf.resignFirstResponder()
        passwordTf.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            layoutSubmitButton(keyboardShowed: true, keyboardHeight: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        layoutSubmitButton(keyboardShowed: false)
    }
    
    @objc func submit() {
        if let controller = self.navigationController?.viewController(class: ViewController.self) {
            if let data = viewModel.processData(title: titleTf.text, username: userNameTf.text, password: passwordTf.text) {
                controller.viewModel.requestData.onNext(data)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func layoutSubmitButton(keyboardShowed: Bool, keyboardHeight: CGFloat = 0) {
        if keyboardShowed {
            submitButton.pin.bottomLeft().right().marginLeft(16).marginRight(16).marginBottom(16 + keyboardHeight).height(50)
        } else {
            submitButton.pin.bottomLeft().right().marginLeft(16).marginRight(16).marginBottom(16).height(50)
        }
    }
    
}
