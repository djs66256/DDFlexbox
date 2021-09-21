//
//  AnimationViewController.swift
//  Example
//
//  Created by daniel on 2021/9/15.
//  Copyright © 2021 daniel. All rights reserved.
//

import Foundation
import DDFlexbox

class AnimationViewController: UIViewController {
    
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func buildButton(_ title: String, _ sel: Selector) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.addTarget(self, action: sel, for: .touchUpInside)
        return btn
    }
    
    func add() {
        
    }
    
    func toBig() {
        
    }
    
    func toSmall() {
        
    }
    
    func toWrap() {
        
    }
    
    func toNoWrap() {
        
    }
    
}
