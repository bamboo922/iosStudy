//
//  ViewController.swift
//  MessageJson
//
//  Created by Pengfei Chen on 16/6/29.
//  Copyright © 2016年 Zhen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,UISearchBarDelegate{
    
    var messages : [AnyObject] = [] //创建空数组messages
    var searchArray : [AnyObject] = [] //创建空数组searchArray
    let Timeformatter = NSDateFormatter() //实例化一个设置时间的类
    let TodayDate = NSDate() //实例化一个时间的类
    
    @IBOutlet weak var messageSearchBar: UISearchBar!
    
    
    //将json文件作为字典传出
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
    
    func sortDate(){
        //取loadJSON函数的返回值
        let dic = loadJSON("messages")
        var messageArray = dic["texts"] as! [AnyObject]
        
        //按日期排列数组方法一 冒泡排序
        //变量f 从0开始
        for f in 0 ..< (messageArray.count - 1) {
            //变量s 从0开始
            for s in 0 ..< (messageArray.count - 1 - f) {
                //取数组其中两个对象
                let first = messageArray[s]
                let second = messageArray[s + 1]
                //取两个对象的时间值
                let firstDateString = first["time"] as! String
                let secondDateString = second["time"] as! String
                //若前一个小于后一个 则将它们调换位置
                if (firstDateString < secondDateString){
                    let order = messageArray[s + 1]
                    messageArray[s + 1] = messageArray[s]
                    messageArray[s] = order
                }
            }
        }
        //将排列好的数组放入空数组messages
        messages = messageArray
        
        //按日期排列数组方法二 sort闭包函数
        //取数组的两个对象
        //let messageOrder = messageArray.sort{(first,second)->Bool in
            //取两个对象的日期值
            //let firstDateString = first["time"] as! String
            //let secondDateString = second["time"] as! String
            //将日期字符串转化为日期
            //Timeformatter.dateFormat = "yyyy-MM-dd HH:mm"
            //let firstDate = Timeformatter.dateFromString(firstDateString)!
            //let secondDate = Timeformatter.dateFromString(secondDateString)!
            //取两日期的差
            //let secondCha = firstDate.timeIntervalSinceDate(secondDate)
            //若差大于0则返回正确 若差小于0则返回错误 
            //表示first大于second 则返回正确
            //if(secondCha > 0){
            //    return true
            //}
            //else{
            //    return false
            //}
        //}
        //messages = messageOrder
    }
    
    //练习冒泡排序
    static func sortArray(orderArray:[Int]) -> [Int]{
        var intArray = [Int](orderArray)
        for f in 0 ..< (intArray.count - 1) {
            for s in 0 ..< (intArray.count - 1 - f) {
                let firstInt = intArray[s]
                let secondInt = intArray[s + 1]
                if firstInt > secondInt {
                    let order = intArray[s + 1]
                    intArray[s + 1] = intArray[s]
                    intArray[s] = order
                }
            }
        }
        return intArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sortDate()
        
        //searchArray = messages
        //设置searchBar代理
        self.messageSearchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        messageSearchBar.showsCancelButton = true
        
        //self.tableView.registerClass(MessageTableViewCell.self, forCellReuseIdentifier: "messageCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //设置列表有一个部分
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //设置短信的数量为列表的行数
        return messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //将每一行与MessageTableViewCell类联系起来
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! MessageTableViewCell
        //将每行的内容放入message
        let message = messages[indexPath.row] as! [String : AnyObject]
        //将日期字符串转为日期
        Timeformatter.dateFormat = "yyyy-MM-dd HH:mm"
        let messageTime = message["time"] as! String
        let messageTime2 = Timeformatter.dateFromString(messageTime)
            
        //计算两日期相差的天数
        let second = TodayDate.timeIntervalSinceDate(messageTime2!)
        let days = (Double(second)) / 86400
            
        //天数小于0.5时 显示几分几秒
        if (days < 0.5){
            Timeformatter.dateFormat = "HH:mm"
            let theTime = Timeformatter.stringFromDate(messageTime2!)
            cell.TimeLabel.text = theTime
        }
                
        //大于0.5小于1.5时 显示昨天
        else if (days > 0.5 && days < 1.5){
            cell.TimeLabel.text = "昨天"
        }
                
        //大于1.5小于8时 显示星期几
        else if (days > 1.5 && days < 8){
            Timeformatter.dateFormat = "EEEE"
            let weeks = Timeformatter.stringFromDate(messageTime2!)
            cell.TimeLabel.text = weeks
        }
                
        //大于8时 显示年月日
        else if (days > 8){
            Timeformatter.dateFormat = "yy/M/dd"
            let theDate = Timeformatter.stringFromDate(messageTime2!)
            cell.TimeLabel.text = theDate
        }
        
        cell.FromLabel.text = message["from"] as? String
        cell.BodyLabel.text = message["body"] as? String

        return cell
        
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        
        //如果搜索词为空 则搜索列表保持不变
        if searchText == " " {
            self.searchArray = self.messages
        }
        else { // 匹配用户输入内容的前缀(不区分大小写)
            self.searchArray = []
            for i in 0 ..< (messages.count - 1){
               let searchResult = messages[i] as! [String : AnyObject]
                for value in searchResult.values{
                   if String(value).lowercaseString.hasPrefix(searchText.lowercaseString)
                    {
                        self.searchArray.append(messages[i])
                    }
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    


}
    
    
    
    
    
    
    



