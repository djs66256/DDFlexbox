//
//  NineGridView.swift
//  Example
//
//  Created by daniel on 2021/9/18.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class NineGridView : UIView, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    
    lazy var imageViews: [UIImageView] = {
        var views: [UIImageView] = []
        for _ in 0..<9 {
            views.append({
                let imageView = UIImageView()
                imageView.backgroundColor = .gray
                return imageView
            }())
        }
        return views
    }()
    
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
        flexbox.column.setup({ (b) in
            for row in 0..<3 {
                b.if(row != 0)?.blocker(height: 5)
                b.row.alignItems(.stretch).setup { (b) in
                    for column in 0..<3 {
                        let view = imageViews[row * 3 + column]
                        b.if(column != 0)?.blocker(width: 5)
                        b.bindView(view).aspectRatio(1).flexGrow(1).flexShrink(1)
                    }
                }
            }
        })
    }
}
