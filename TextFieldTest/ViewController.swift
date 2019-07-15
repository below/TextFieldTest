//
//  ViewController.swift
//  TextViewTest
//
//  Created by Alexander v. Below on 15.07.19.
//  Copyright © 2019 Alexander von Below. All rights reserved.
//

import UIKit

class TestTextField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponder.copy(_:)) {
            return true
        } else {
            return false
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        if super.becomeFirstResponder() {
            self.isHighlighted = true
            return true
        } else {
            return false
        }
    }
    
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = self.text
        self.isHighlighted = false
        self.resignFirstResponder()
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

//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        return self
//    }
    
}

class TestView: UIView {
    
    var currentCopyText: String?
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            for subview in self.subviews {
                let frame = subview.frame
                if let textField = subview as? UITextField, frame.contains(point) {
                    self.becomeFirstResponder()
                    self.currentCopyText = textField.text
                    let menu = UIMenuController.shared
                    menu.setTargetRect(frame, in: self)
                    menu.setMenuVisible(true, animated: true)
                    menu.update()
                }
            }
        }
    }
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = currentCopyText
        self.resignFirstResponder()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponder.copy(_:)) {
            return self.currentCopyText != nil
        } else {
            return false
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

