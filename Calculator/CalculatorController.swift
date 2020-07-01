//
//  ViewController.swift
//  Calculator
//
//  Created by 권성우 on 2020/05/25.
//  Copyright © 2020 권성우. All rights reserved.
//

import UIKit

class CalculatorController: UIViewController {
    
    @IBOutlet private var display: UILabel!
    var inTyping : Bool = false
    
    var displayValue :Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text! = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        display!.text! = "0"
    }
    @IBAction func clearDisplay(_ sender: UIButton) {
        display.text! = "0"
        inTyping = false
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if (inTyping) {
            let presentTypeStatus = display!.text!
            display!.text! =  presentTypeStatus + digit
        }else{
            display!.text! = digit
        }
        inTyping = true
    }
    
    private var brain : CalculatorBrain = CalculatorBrain()

    @IBAction func performOperation(_ sender: UIButton) {
        if inTyping{
            brain.setOperand(operand: displayValue)
            inTyping = false
        }
        if let mathmaticalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathmaticalSymbol)
        }
        displayValue = brain.result
    }
}

