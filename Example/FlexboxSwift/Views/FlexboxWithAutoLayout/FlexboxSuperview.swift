//
//  WorkWithAutoLayoutView.swift
//  Example
//
//  Created by daniel on 2021/9/21.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class FlexboxSuperview : UIView, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    
    let imageView = UIImageView()
    let textView  = AutoLayoutSubview()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flexbox.layoutSubviews()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return flexbox.sizeThatFits(size)
    }
    
    override var intrinsicContentSize: CGSize {
        return flexbox.intrinsicContentSize
    }
    
    func updateFlexboxLayout() {
        flexbox.row.padding(10).setup { (b) in
            b.bindView(imageView).width(40).height(40)
            b.blocker(width: 10)
            b.bindView(textView).flexGrow(1).flexShrink(1)
        }
    }
}
