//
//  AutoLayoutSuperview.swift
//  FlexboxSwift
//
//  Created by daniel on 2021/9/21.
//  Copyright © 2021 daniel. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AutoLayoutSuperview: UIView {
    let imageView = UIImageView()
    let textView  = FlexboxSubview()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.green.withAlphaComponent(0.1)
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        addSubview(imageView)
        
        addSubview(textView)
        
        imageView.snp.makeConstraints { (m) in
            m.left.equalToSuperview().inset(10)
            m.top.lessThanOrEqualToSuperview().inset(10)
            m.bottom.greaterThanOrEqualToSuperview().inset(10)
            m.width.equalTo(40)
            m.height.equalTo(40)
        }
        textView.snp.makeConstraints { (m) in
            m.left.equalTo(imageView.snp.right).offset(10)
            m.right.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
