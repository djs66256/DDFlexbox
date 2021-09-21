//
//  FlexboxSubview.swift
//  Example
//
//  Created by daniel on 2021/9/21.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class FlexboxSubview : UIView, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    let textLabel = UILabel()
    let detailTextLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        
        textLabel.text = "I am text label"
        
        detailTextLabel.font = .systemFont(ofSize: 13)
        detailTextLabel.textColor = .gray
        detailTextLabel.text = "I am detail text label"
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
        flexbox.column.setup { (b) in
            b.bindView(textLabel)
            b.bindView(detailTextLabel)
        }
    }
}
