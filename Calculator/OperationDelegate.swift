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
    func appendQuery(s: String)
    func unAppendQuery()
    func clearQuery()
    func getListFromInput() -> [String]
    func toPostFix(query: [String]) -> [String]
    func toBXT(query: [String]) -> TreeNode
    func returnValue() -> Double
}