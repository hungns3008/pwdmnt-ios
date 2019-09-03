//
//  DetailController.swift
//  Template
//
//  Created by Hung Nguyen on 9/3/19.
//  Copyright © 2019 Hung Nguyen. All rights reserved.
//

import UIKit
import PinLayout

class DetailController: UIViewController {
    
    let viewModel  = DetailViewModel()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var accountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(titleLabel)
        view.addSubview(accountLabel)
        view.addSubview(passwordLabel)
        
        if let model = viewModel.detailModel {
            titleLabel.text = "Account Name: \(model.title)"
            accountLabel.text = "Account: \(model.name)"
            passwordLabel.text = "Password: \(model.password)"
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.pin.left().top(view.pin.safeArea.top + 16).right().marginLeft(16).marginRight(16).sizeToFit()
        accountLabel.pin.left().below(of: titleLabel).right().marginLeft(16).marginRight(16).sizeToFit()
        passwordLabel.pin.left().below(of: accountLabel).right().marginLeft(16).marginRight(16).sizeToFit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
