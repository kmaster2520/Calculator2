//
//  OperationDelegate.swift
//  Calculator
//
//  Created by Sathvik Kadaveru on 11/15/15.
//  Copyright © 2015 iOS Club. All rights reserved.
//

import Foundation

protocol OperationDelegate {
    func getQuery() -> String
    func appendQuery(_ s: String)
    func unAppendQuery()
    func clearQuery()
    func getListFromInput() -> [String]
    func toPostFix(_ query: [String]) -> [String]
    func toBXT(_ query: [String]) -> TreeNode
    func returnValue() -> Double
}
