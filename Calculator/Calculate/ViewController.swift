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

    func inputNumber(_ number:String){
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
    
    func inputSimbol(_ simbol:String){
        Fuhao = simbol
        exitSimbol = true
        self.displaySimbol.text = simbol
    }
    
    @IBAction func num1(_ sender: AnyObject) {
        inputNumber("1")
    }
    
    @IBAction func num2(_ sender: AnyObject) {
        inputNumber("2")
    }

    @IBAction func num3(_ sender: AnyObject) {
        inputNumber("3")
    }
    
    @IBAction func num4(_ sender: AnyObject) {
        inputNumber("4")
    }
    
    @IBAction func num5(_ sender: AnyObject) {
        inputNumber("5")
    }

    @IBAction func num6(_ sender: AnyObject) {
        inputNumber("6")
    }
    
    @IBAction func num7(_ sender: AnyObject) {
        inputNumber("7")
    }
    
    @IBAction func num8(_ sender: AnyObject) {
        inputNumber("8")
    }
    
    @IBAction func num9(_ sender: AnyObject) {
        inputNumber("9")
    }

    @IBAction func num0(_ sender: AnyObject) {
        inputNumber("0")
    }
    
    @IBAction func point(_ sender: AnyObject) {
        inputNumber(".")
    }
    
    @IBAction func delet(_ sender: AnyObject) {
        self.displayNum1.text = ""
        self.displayNum2.text = ""
        self.displaySimbol.text = ""
        self.displayResult.text = ""
        exitSimbol = false
    }
    
    @IBAction func plus(_ sender: AnyObject) {
        inputSimbol("+")
    }
    
    @IBAction func minus(_ sender: AnyObject) {
        inputSimbol("-")
    }
    
    @IBAction func multiple(_ sender: AnyObject) {
        inputSimbol("*")
    }
    
    @IBAction func devide(_ sender: AnyObject) {
        inputSimbol("/")
    }
    
    @IBAction func dengyu(_ sender: AnyObject) {
         exitSimbol = false
         if (Fuhao == "+"){
            if(firstNumber.contains(".") == false){
                if(secondNumber.contains(".") == false){
                    result = Int(firstNumber)! + Int(secondNumber)!
                    self.displayResult.text = "\(result)"
                }
                else{
                    finalResult = Double(firstNumber)! + Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
            }
            else if(firstNumber.contains(".") == true){
                if(secondNumber.contains(".") == true){
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
            if(firstNumber.contains(".") == false){
                if(secondNumber.contains(".") == false){
                    result = Int(firstNumber)! - Int(secondNumber)!
                    self.displayResult.text = "\(result)"
                }
                else{
                    finalResult = Double(firstNumber)! - Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
            }
            else if(firstNumber.contains(".") == true){
                if(secondNumber.contains(".") == true){
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
            if(firstNumber.contains(".") == false){
                if(secondNumber.contains(".") == false){
                    result = Int(firstNumber)! * Int(secondNumber)!
                    self.displayResult.text = "\(result)"
                }
                else{
                    finalResult = Double(firstNumber)! * Double(secondNumber)!
                    self.displayResult.text = "\(finalResult)"
                }
            }
            else if(firstNumber.contains(".") == true){
                if(secondNumber.contains(".") == true){
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
                intResult = stringResult.replacingOccurrences(of: ".0",with: "")
                self.displayResult.text = "\(intResult)"
            }
            else{
                self.displayResult.text = "\(finalResult)"
            }
         }
    }
}


    





