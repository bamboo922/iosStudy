//
//  ViewController.swift
//  ReadJson
//
//  Created by Pengfei Chen on 16/6/28.
//  Copyright © 2016年 Zhen. All rights reserved.
//

import UIKit

class ViewController:
    UITableViewController{
    //创建一个空的数组
    var forms : [AnyObject] = []
    
    func loadJSON(fileName: String) -> [String:AnyObject] {
        let fileUrl : NSURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: "json")!
        
        let jsonData = NSData(contentsOfURL: fileUrl)
        
        var dictionary = [String:AnyObject]()
        
        if let data = jsonData {
            var json: AnyObject!
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
            } catch {
                
            }
            dictionary = json as! [String:AnyObject]
        }
        return dictionary
    }
    func sitejson(){
        //将返回的数据放进dic
        let dic = loadJSON("forms")
        //将这些数据放进空数组
        forms = dic["forms"] as! [AnyObject]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       sitejson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //返回列表有1个部分
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //此部分中的行数为forms中对象的数量
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forms.count
    }
    //返回所有行的行高
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //将界面formcell与类FormTableViewCell联系起来
        let cell = tableView.dequeueReusableCellWithIdentifier("formCell") as! FormTableViewCell
        //把数组中的每一行转换成键值对
        let form = forms[indexPath.row] as! [String : AnyObject]
        //将id的整数类型转换为字符串类型 并输入列表
        let ID = form["id"]!
        let IDString = String(ID)
        cell.formIdLabel.text = IDString
        //将version的整数类型转换为字符串类型 并输入列表
        let VERSION = form["version"]!
        let VERSIONString = String(VERSION)
        cell.formVersionLabel.text = VERSIONString
        //将countru_from的空值符号转换为字符串类型 并输入列表
        let FROM = form["country_from"]!
        let FROMString = String(FROM)
        cell.formCountryfromLabel.text = FROMString
        //将name值输入列表
        cell.formNameLabel.text = form["name"] as? String
        //将description值输入列表
        cell.formDescriptionLabel.text = form["description"] as? String
        //将countru_to值输入列表
        cell.formCountrytoLabel.text = form["country_to"] as? String
        //将country值输入列表
        cell.formCountryLabel.text = form["country"] as? String
        //返回列表值
        return cell
    }
    
    
    
    
    

}

