//
//  AnimationViewController.swift
//  FlexboxSwift
//
//  Created by daniel on 2021/9/21.
//  Copyright © 2021 daniel. All rights reserved.
//

import Foundation
import UIKit

class AnimationViewController : UIViewController {
    
    var datas : [AnimationView1Style] = [.style1, .style2, .style3, .style4]
    var cursor = 0
    let animtionView = AnimationView1()
    
    let animationView2 = AnimationView2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "switch", style: .plain, target: self, action: #selector(next(sender:)))
        
        animtionView.backgroundColor = UIColor.green.withAlphaComponent(0.1)
        animtionView.style = datas[cursor]
        view.addSubview(animtionView)
        
        animationView2.backgroundColor = UIColor.green.withAlphaComponent(0.1)
        view.addSubview(animationView2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animtionView.frame = CGRect(x: 10, y: 100, width: view.frame.width - 20, height: 50)
        
        animationView2.frame = CGRect(x: 40, y: 300, width: view.frame.width - 80, height: 50)
    }
    
    @objc
    func next(sender: Any) {
        cursor += 1
        if cursor >= datas.count {
            cursor = 0
        }
        
        UIView.animate(withDuration: 0.3) {
            self.animtionView.style = self.datas[self.cursor]
            self.animtionView.layoutIfNeeded()
        }
        
        animationView2.alignLeft = !animationView2.alignLeft
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .init(rawValue: 0), animations: {
            self.animationView2.layoutIfNeeded()
        }, completion: nil)
    }
}
