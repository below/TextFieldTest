//
//  ViewController.swift
//  TextViewTest
//
//  Created by Alexander v. Below on 15.07.19.
//  Copyright © 2019 Alexander von Below. All rights reserved.
//

import UIKit

class TestTextField: UITextField {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print ("Boom");
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let menu = UIMenuController.shared
        if self.isFirstResponder {
            self.isHighlighted = false
            menu.setMenuVisible(false, animated: true)
            menu.update()
            self.resignFirstResponder()
        } else if self.becomeFirstResponder() {
            menu.setTargetRect(self.bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponder.copy(_:)) {
            return true
        } else {
            return false
        }
    }
    
    override func copy(_ sender: Any?) {
        print ("Foomp")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

