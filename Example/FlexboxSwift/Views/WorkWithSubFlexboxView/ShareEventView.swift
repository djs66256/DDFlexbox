//
//  ShareEventView.swift
//  Example
//
//  Created by daniel on 2021/9/19.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class ShareEventView : UIView, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    
    let avatarView = UIImageView()
    let nameLabel = UILabel()
    let timeLabel = UILabel()
    let actionLabel = UILabel()
    let textLabel = UILabel()
    let picsView = NineGridView()
    let cardView = SubCardView()
    let picsNode = NineGridNode()
    
    var useNode = false {
        didSet {
            self.setNeedsUpdateFlexboxLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        avatarView.backgroundColor = .gray
        avatarView.layer.cornerRadius = 5;
        avatarView.clipsToBounds = true
        
        nameLabel.text = "苍耳"
        
        timeLabel.textColor = .lightGray
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.text = "2021-09-05"
        
        actionLabel.textColor = .lightGray
        actionLabel.text = "分享歌曲："
        
        textLabel.text = "今天闺蜜结婚，把我哭的稀里哗啦的！闺蜜问我怎么了，我说：“好白菜都让猪拱了”！闺蜜笑笑说：“不亏，毕竟家里还多了头猪”！\n致闺蜜：快乐有很多种，见到你是第一种！我永远需要你，也希望永远被你需要！最好的时光在路上，所有的快乐不用假装！好朋友就是能看见，彼此头顶上的光环的人啊！途有好伴，不觉路远！"
        textLabel.numberOfLines = 0
        
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
        flexbox.row.padding(10).setup({ (b) in
            b.bindView(avatarView).height(30).width(30)
            b.column.marginLeft(10).flexShrink(1).flexGrow(1).setup { (b) in
                b.column.height(30).marginBottom(5).justifyContent(.center).setup { (b) in
                    b.row.setup { (b) in
                        b.bindView(nameLabel).marginRight(5)
                        b.bindView(actionLabel)
                    }
                    b.bindView(timeLabel)
                }
                b.bindView(textLabel).marginBottom(5)
                if !useNode {
                    b.connect(picsView)
                }
                else {
                    b.connect(picsNode)
                }
                b.blocker(height: 10)
                b.connect(cardView)
            }
        })
    }
}
