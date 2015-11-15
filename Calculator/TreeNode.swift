//
//  TreeNode.swift
//  Calculator
//
//  Created by Sathvik Kadaveru on 11/15/15.
//  Copyright © 2015 iOS Club. All rights reserved.
//

import Foundation

class TreeNode {
    let value : String
    var left: TreeNode?
    var right: TreeNode?
    
    init(value: String, left: TreeNode?, right: TreeNode?) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    convenience init(value: String) {
        self.init(value: value, left: nil, right: nil)
    }
    
    func setLeft(newLeft: TreeNode) {
        self.left = newLeft
    }
    
    func setRight(newRight: TreeNode) {
        self.right = newRight
    }
    
    func eval() -> Double {
        if value == "+" {
            return left!.eval() + right!.eval()
        }
        if value == "-" {
            return left!.eval() - right!.eval()
        }
        if value == "*" {
            return left!.eval() * right!.eval()
        }
        if value == "/" {
            return left!.eval() / right!.eval()
        }
        if value == "^" {
            return pow(left!.eval(), right!.eval())
        } else {
            return Double(value)!
        }
    }
}
