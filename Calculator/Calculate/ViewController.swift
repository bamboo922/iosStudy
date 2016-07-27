//
//  ViewController.swift
//  Calculate
//
//  Created by Pengfei Chen on 15/12/26.
//  Copyright © 2015年 Zhen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayNum1: UILabel!
    @IBOutlet weak var displaySimbol: UILabel!
    @IBOutlet weak var displayNum2: UILabel!
    @IBOutlet weak var displayResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var firstNumber : String = ""
    var secondNumber : String = ""
    var beforeNumber : String = ""
    var Fuhao : String = ""
    var result : Int = 0
    var finalResult : Double = 0
    var stringResult : String = ""
    var intResult : String = ""
    var exitSimbol : Bool = false

    func inputNumber(number:String){
        if exitSimbol == false {
            beforeNumber = self.displayNum1.text!
            firstNumber = beforeNumber + number
            self.displayNum1.text = firstNumber
        }
        else{
            beforeNumber = self.displayNum2.text!
            secondNumber = beforeNumber + number
            self.displayNum2.text = secondNumber
        }
    }
    
    func inputSimbol(simbol:String){
        Fuhao = simbol
        exitSimbol = true
        self.displaySimbol.text = simbol
    }
    
    @IBAction func num1(sender: AnyObject) {
        inputNumber("1")
    }
    
    @IBAction func num2(sender: AnyObject) {
        inputNumber("2")
    }

    @IBAction func num3(sender: AnyObject) {
        inputNumber("3")
    }
    
    @IBAction func num4(sender: AnyObject) {
        inputNumber("4")
    }
    
    @IBAction func num5(sender: AnyObject) {
        inputNumber("5")
    }

    @IBAction func num6(sender: AnyObject) {
        inputNumber("6")
    }
    
    @IBAction func num7(sender: AnyObject) {
        inputNumber("7")
    }
    
    @IBAction func num8(sender: AnyObject) {
        inputNumber("8")
    }
    
    @IBAction func num9(sender: AnyObject) {
        inputNumber("9")
    }

    @IBAction func num0(sender: AnyObject) {
        inputNumber("0")
    }
    
    @IBAction func point(sender: AnyObject) {
        inputNumber(".")
    }
    
    @IBAction func delet(sender: AnyObject) {
        self.displayNum1.text = ""
        self.displayNum2.text = ""
        self.displaySimbol.text = ""
        self.displayResult.text = ""
        exitSimbol = false
    }
    
    @IBAction func plus(sender: AnyObject) {
        inputSimbol("+")
    }
    
    @IBAction func minus(sender: AnyObject) {
        inputSimbol("-")
    }
    
    @IBAction func multiple(sender: AnyObject) {
        inputSimbol("*")
    }
    
    @IBAction func devide(sender: AnyObject) {
        inputSimbol("/")
    }
    
    @IBAction func dengyu(sender: AnyObject) {
         exitSimbol = false
         if (Fuhao == "+"){
            if(firstNumber.containsString(".") == false){
                if(secondNumber.containsString(".") == false){
                    result = Int(firstNumber)! + Int(secondNumber)!
                    self.displayResult.text = "\(result)"
                }
                else{
                    finalResult = Double(firstNumber)! + Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
            }
            else if(firstNumber.containsString(".") == true){
                if(secondNumber.containsString(".") == true){
                    finalResult = Double(firstNumber)! + Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
                else{
                    finalResult = Double(firstNumber)! + Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
            }
         }
        
         else if (Fuhao == "-"){
            if(firstNumber.containsString(".") == false){
                if(secondNumber.containsString(".") == false){
                    result = Int(firstNumber)! - Int(secondNumber)!
                    self.displayResult.text = "\(result)"
                }
                else{
                    finalResult = Double(firstNumber)! - Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
            }
            else if(firstNumber.containsString(".") == true){
                if(secondNumber.containsString(".") == true){
                    finalResult = Double(firstNumber)! - Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
                else{
                    finalResult = Double(firstNumber)! - Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
            }
         }
        
         else if (Fuhao == "*"){
            if(firstNumber.containsString(".") == false){
                if(secondNumber.containsString(".") == false){
                    result = Int(firstNumber)! * Int(secondNumber)!
                    self.displayResult.text = "\(result)"
                }
                else{
                    finalResult = Double(firstNumber)! * Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
            }
            else if(firstNumber.containsString(".") == true){
                if(secondNumber.containsString(".") == true){
                    finalResult = Double(firstNumber)! * Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
                else{
                    finalResult = Double(firstNumber)! * Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
            }
         }
        
         else if (Fuhao == "/"){
            finalResult = Double(firstNumber)! / Double(secondNumber)!
            stringResult = String(finalResult)
            if(stringResult.hasSuffix(".0") == true){
                intResult = stringResult.stringByReplacingOccurrencesOfString(".0",withString: "")
                self.displayResult.text = "\(intResult)"
            }
            else{
                self.displayResult.text = "\(finalResult)"
            }
         }
    }
}


    





