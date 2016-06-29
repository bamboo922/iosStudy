//
//  ViewController.swift
//  HelloWorld
//
//  Created by Pengfei Chen on 15/12/26.
//  Copyright © 2015年 Zhen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var twowords: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func wordscolor(sender: AnyObject) {
    twowords.textColor = UIColor.redColor()
        
    }

}

