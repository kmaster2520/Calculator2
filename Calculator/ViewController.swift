//
//  ViewController.swift
//  Calculator
//

import UIKit

class ViewController: UIViewController {

    let calculations: OperationDelegate = InputHandler()
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        calculations.clearQuery()
        resultLabel.text = "0"
    }
    
    @IBAction func delButtonPressed(sender: UIButton) {
        calculations.unAppendQuery()
        resultLabel.text = calculations.getQuery()
    }
    
    @IBAction func opButtonPressed(sender: UIButton) {
        let buttonTitle = sender.titleLabel!.text!
        calculations.appendQuery(buttonTitle)
        resultLabel.text = calculations.getQuery()
    }
    
    @IBAction func equalsButtonPressed(sender: UIButton) {
        var result = String(format:"%12.10f", calculations.returnValue())
        //print(result)
        resultLabel.text = trim0(result)
        calculations.clearQuery()
    }
    
    func trim0(result: String) -> String {
        var res = String(result)
        while !res.characters.isEmpty && res.characters.last! == "0" {
            res = String(res.characters.dropLast())
        }
        if !res.characters.isEmpty && res.characters.last! == "." {
            res = String(res.characters.dropLast())
        }
        return res
    }
    
}

