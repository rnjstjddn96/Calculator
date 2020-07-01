//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 권성우 on 2020/05/26.
//  Copyright © 2020 권성우. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    var operations : Dictionary<String,Operation> = [
        "e" : Operation.Constant(M_E), //M_E
        "√" : Operation.Unary(sqrt), //sqrt
        "cos" : Operation.Unary(cos), //cos
        "+" : Operation.Binary({$0 + $1}),
        "-" : Operation.Binary({$0 - $1}),
        "*" : Operation.Binary({$0 * $1}),
        "/" : Operation.Binary({$0 / $1}),
        "=" : Operation.Equals
    ]
    
    enum Operation{
        case Constant(Double)
        case Unary((Double) -> Double)
        case Binary((Double,Double)->Double)
        case Equals
    }
    
    func performOperation(symbol : String){
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value): accumulator = value
            case .Unary(let function): accumulator = function(accumulator)
            case .Binary(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
            
        }
        
    }
    private var pending : PendingBinaryOperationInfo?
    private func executePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    private struct PendingBinaryOperationInfo {
        var binaryFunction : (Double, Double)->Double
        var firstOperand : Double
    }
    var result : Double
    {
        get{
            return accumulator
        }
    }
}
