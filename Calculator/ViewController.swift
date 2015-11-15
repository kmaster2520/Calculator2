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
        resultLabel.text = calculations.getQuery()
    }
    
    @IBAction func delButtonPressed(sender: UIButton) {
        //TODO
    }
    
    @IBAction func opButtonPressed(sender: UIButton) {
        let buttonTitle = sender.titleLabel!.text!
        calculations.appendQuery(buttonTitle)
        resultLabel.text = calculations.getQuery()
    }
    
    @IBAction func equalsButtonPressed(sender: UIButton) {
        resultLabel.text = String(calculations.returnValue())
        calculations.clearQuery()
    }
    
}

