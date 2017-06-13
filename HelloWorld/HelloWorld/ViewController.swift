//
//  ViewController.swift
//  HelloWorld
//
//  Created by Pengfei Chen on 15/12/26.
//  Copyright © 2015年 Zhen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var number:[String] = []

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var export: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func calculate(){
        print(number)
        var shuzi = self.input.text
        var i = 0
        for i in 0..<number.count {
            number[i] = shuzi!
        }
        
    }
    @IBAction func calculate(_ sender: Any) {
        calculate()
      
    
    }
    
    
    
}

