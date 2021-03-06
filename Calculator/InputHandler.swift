//
//  InputHandler.swift
//  Calculator
//
//  Created by Sathvik Kadaveru on 11/15/15.
//  Copyright © 2015 iOS Club. All rights reserved.
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


extension Character {
    var val: UInt32 {
        return String(self).unicodeScalars.first!.value
    }
}

class InputHandler: OperationDelegate {
    
    var query: String
    let order: [String: Int] = ["+": 0, "-": 0, "*": 1, "/": 1, "^": 2, "(": -1, ")": 3]
    //let operands: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    init() {
        query = ""
    }
    
    func getQuery() -> String {
        return query + ""
    }
    
    func appendQuery(_ s: String) {
        query += s
    }
    
    func unAppendQuery() {
        query = String(query.characters.dropLast())
    }
    
    func clearQuery() {
        query = ""
    }

    func getListFromInput() -> [String] {
        var ls: [String] = ["$"]
        var parens: Int = 0
        //
        //print(query)
        for ch in query.characters {
            if ch == "*" || ch == "/" || ch == "^" {
                // as operator
                if isOperand(ls.last) || ls.last == ")" {
                    ls.append(String(ch))
                }
            } else if ch == "+" || ch == "-" {
                // as operand
                if isOperator(ls.last) {
                    ls.append(String(ch) + "0")
                }
                // as operator
                else if isOperand(ls.last) || ls.last == ")" || ls.last == "$" {
                    ls.append(String(ch))
                }
            } else if isOperand(String(ch)) {
                if isOperand(ls.last) {
                    ls.append(ls.removeLast() + String(ch))
                } else if ls.last == ")" {
                    ls.append("*")
                    ls.append(String(ch))
                } else {
                    ls.append(String(ch))
                }
            } else if ch == "(" {
                parens += 1
                if isOperand(ls.last) {
                    ls.append("*")
                }
                ls.append(String(ch))
            } else if ch == ")" {
                if parens == 0 {
                    continue
                } else {
                    parens -= 1
                }
                if isOperator(ls.last) {
                    ls.removeLast()
                }
                if ls.last == "(" {
                    ls.removeLast()
                    continue
                }
                ls.append(String(ch))
            }
        }
        
        while parens > 0 {
            if isOperator(ls.last) {
                ls.removeLast()
            }
            ls.append(")")
            parens -= 1
        }
        
        while !ls.isEmpty && isOperator(ls.last) {
            ls.removeLast()
        }
        
        ls.removeFirst()
        while !ls.isEmpty && isOperator(ls.first) {
            ls.removeFirst()
        }
        
        //print(ls)
        return ls
    }
    
    func isOperand(_ ch: String?) -> Bool {
        if ch == nil {
            return false
        }
        if let _ = Int(ch!) {
            return true
        }
        return false
    }
    
    func isOperator(_ ch: String?) -> Bool {
        if ch == nil {
            return false
        }
        return ch == "*" || ch == "/" || ch == "+" || ch == "-" || ch == "^"
    }

    func toPostFix(_ query: [String]) -> [String] {
        var opStack: [String] = []
        var postfix: [String] = []
        
        for s in query {
            if s == "$" {
                continue
            }
            if isOperand(s) {
                postfix.append(s)
            } else if isOperator(s) {
                while !opStack.isEmpty && order[opStack.last!] >= order[s] {
                    postfix.append(opStack.removeLast())
                }
                opStack.append(s)
            } else if s == "(" {
                opStack.append(s)
            } else if s == ")" {
                while !opStack.isEmpty && opStack.last! != "(" {
                    postfix.append(opStack.removeLast())
                }
                if !opStack.isEmpty && opStack.last! == "(" {
                    opStack.removeLast()
                }
            }
        }
        
        while !opStack.isEmpty {
            postfix.append(opStack.removeLast())
        }
        
        //print(postfix)
        return postfix
    }
    
    func toBXT(_ query: [String]) -> TreeNode {
        if query.isEmpty {
            return TreeNode(value: "0")
        }
        var bxtStack: [TreeNode] = []
        for ch in query {
            let newNode: TreeNode = TreeNode(value: ch)
            if isOperator(ch) {
                newNode.setRight(bxtStack.removeLast())
                newNode.setLeft(bxtStack.removeLast())
            }
            bxtStack.append(newNode)
        }
        return bxtStack.removeLast()
    }
    
    func returnValue() -> Double {
        let root: TreeNode = toBXT(toPostFix(getListFromInput()))
        return root.eval()
    }
}
