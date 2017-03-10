//
//  ViewController.swift
//  Calculator
//

import UIKit

class ViewController: UIViewController {

    let calculations: OperationDelegate = InputHandler()
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        calculations.clearQuery()
        resultLabel.text = "0"
    }
    
    @IBAction func delButtonPressed(_ sender: UIButton) {
        calculations.unAppendQuery()
        resultLabel.text = calculations.getQuery()
    }
    
    @IBAction func opButtonPressed(_ sender: UIButton) {
        let buttonTitle = sender.titleLabel!.text!
        calculations.appendQuery(buttonTitle)
        resultLabel.text = calculations.getQuery()
    }
    
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
        let returned = calculations.returnValue()
        let result = abs(returned.truncatingRemainder(dividingBy: 1)) < 0.00000001 ? String(format: "%.0f", returned) : String(format: "%12.8f", returned)
        print(result)
        resultLabel.text = result//trim0(result)
        calculations.clearQuery()
    }
    
    func trim0(_ result: String) -> String {
        var res = String(result)
        while !(res?.characters.isEmpty)! && res?.characters.last! == "0" {
            res = String(describing: res?.characters.dropLast())
        }
        if !(res?.characters.isEmpty)! && res?.characters.last! == "." {
            res = String(describing: res?.characters.dropLast())
        }
        return res!
    }
    
}

