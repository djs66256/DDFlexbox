//
//  NineGridNode.swift
//  FlexboxSwift
//
//  Created by daniel on 2021/9/20.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class NineGridNode : FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    
    let imageViews: [UIImageView] = {
        var views: [UIImageView] = []
        for _ in 0..<9 {
            views.append({
                let imageView = UIImageView()
                imageView.backgroundColor = .red
                return imageView
            }())
        }
        return views
    }()
    
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
