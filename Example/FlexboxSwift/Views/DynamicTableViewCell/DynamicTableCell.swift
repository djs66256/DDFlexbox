//
//  DynamicTableCell.swift
//  Example
//
//  Created by daniel on 2021/9/20.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class DynamicTableCellModel {
    var image: UIImage?
    var title: String?
    var detailText: String?
}

class DynamicTableCell : UITableViewCell, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let myTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "My title label"
        label.backgroundColor = .gray
        return label
    }()
    
    let myDetailTextLabel: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize: 14)
           label.text = "My detail text label"
           label.backgroundColor = .lightGray
           return label
       }()
    
    var model: DynamicTableCellModel? {
        didSet {
            self.setNeedsUpdateFlexboxLayout()
        }
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
        flexbox.row.padding(10).alignItems(.center).setup({ (b) in
            b.ifExists(model?.image)?.bindView(myImageView).width(40).height(40)
            b.ifExists(model?.image)?.blocker(width: 10)
            b.column.flexGrow(1).flexShrink(1).setup { (b) in
                b.ifExists(model?.title)?.bindView(myTextLabel)
                b.ifExists(model?.detailText)?.bindView(myDetailTextLabel)
            }
        })
    }
}
