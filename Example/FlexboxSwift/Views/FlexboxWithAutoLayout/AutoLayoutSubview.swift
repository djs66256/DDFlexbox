//
//  AutoLayoutView.swift
//  FlexboxSwift
//
//  Created by daniel on 2021/9/21.
//  Copyright © 2021 daniel. All rights reserved.
//

import Foundation
import SnapKit

class AutoLayoutSubview: UIView {
    let textLabel = UILabel()
    let detailTextLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.green.withAlphaComponent(0.1)
        
        textLabel.text = "I am text label"
        addSubview(textLabel)
        
        detailTextLabel.font = .systemFont(ofSize: 13)
        detailTextLabel.textColor = .gray
        detailTextLabel.text = "I am detail text label"
        addSubview(detailTextLabel)
        
        textLabel.snp.makeConstraints { (m) in
            m.top.left.right.equalToSuperview()
        }
        detailTextLabel.snp.makeConstraints { (m) in
            m.top.equalTo(textLabel.snp.bottom)
            m.bottom.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
