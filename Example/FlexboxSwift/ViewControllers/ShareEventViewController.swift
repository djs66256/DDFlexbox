//
//  ShareEventViewController.swift
//  FlexboxSwift
//
//  Created by daniel on 2021/9/20.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit

class ShareEventViewViewController: UIViewController {
    let shareView = ShareEventView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        shareView.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        view.addSubview(shareView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "connect switch", style: .plain, target: self, action: #selector(switchConnect(sender:)))
    }
    
    @objc
    func switchConnect(sender: Any) {
        shareView.useNode = !shareView.useNode
//        shareView.updateFlexboxLayoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = shareView.sizeThatFits(CGSize(width: view.frame.width, height: CGFloat.greatestFiniteMagnitude))
        shareView.frame = CGRect(x: 0, y: 100, width: size.width, height: size.height)
    }
}
