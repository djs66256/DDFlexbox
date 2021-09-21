//
//  NodeView.swift
//  Example
//
//  Created by daniel on 2021/9/21.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class NodeView : UIView, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    
    let node = TableLikeNode()
    
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
        flexbox.row.alignContent(.stretch).setup { (b) in
            b.connect(node).flexGrow(1).flexShrink(1)
        }
    }
}
