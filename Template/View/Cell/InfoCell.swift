//
//  InfoCell.swift
//  Template
//
//  Created by Hung Nguyen on 8/26/19.
//  Copyright © 2019 Hung Nguyen. All rights reserved.
//

import UIKit
import PinLayout

final class InfoCell: UICollectionViewCell {
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var divider: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(contentLabel)
        addSubview(divider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        divider.pin.left().right().bottom().margin(16).height(0.5)
        contentLabel.pin.topLeft().right().marginLeft(16).marginRight(16).marginTop(8).marginBottom(8).above(of: divider);
    }
    
    func configure(viewModel: InfoModel) {
        contentLabel.text = "\(viewModel.title) - \(viewModel.name)"
        layout()
    }
    
}
