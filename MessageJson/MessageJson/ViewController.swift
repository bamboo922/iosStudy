//
//  ViewController.swift
//  MessageJson
//
//  Created by Pengfei Chen on 16/6/29.
//  Copyright © 2016年 Zhen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var messages : [AnyObject] = []
    let Timeformatter = NSDateFormatter()
    let TodayDate = NSDate()
    

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
        
        //let array = [1,2,3,4]
        //let sortedArray = array.sort{(first,second)-> Bool in
        //    return false
        //}
        //print(sortedArray)
        
        return dictionary
    }
    
    func siteMessage(){
        let dic = loadJSON("messages")
        let messageArray = dic["texts"] as! [AnyObject]
        let messageOrder = messageArray.sort{(first,second)->Bool in
            let firstDateString = first["time"] as! String
            let secondDateString = second["time"] as! String
            
            Timeformatter.dateFormat = "yyyy-MM-dd HH:mm"
            let firstDate = Timeformatter.dateFromString(firstDateString)!
            let secondDate = Timeformatter.dateFromString(secondDateString)!
            let secondCha = firstDate.timeIntervalSinceDate(secondDate)
            if(secondCha > 0){
                return true
            }
            else{
                return false
            }
        }
        messages = messageOrder
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        siteMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! MessageTableViewCell
        
        let message = messages[indexPath.row] as! [String : AnyObject]
        
        
        Timeformatter.dateFormat = "yyyy-MM-dd HH:mm"
        let messageTime = message["time"] as! String
        let messageTime2 = Timeformatter.dateFromString(messageTime)
        
        let second = TodayDate.timeIntervalSinceDate(messageTime2!)
        let days = (Double(second)) / 86400
    
        if (days < 0.5){
            Timeformatter.dateFormat = "HH:mm"
            let theTime = Timeformatter.stringFromDate(messageTime2!)
            cell.TimeLabel.text = theTime
        }
        
        else if (days > 0.5 && days < 1){
            cell.TimeLabel.text = "昨天"
        }
            
        else if (days > 1 && days < 8){
            Timeformatter.dateFormat = "EEEE"
            let weeks = Timeformatter.stringFromDate(messageTime2!)
            cell.TimeLabel.text = weeks
        }
        
       else if (days > 8){
            Timeformatter.dateFormat = "yy/M/dd"
            let theDate = Timeformatter.stringFromDate(messageTime2!)
            cell.TimeLabel.text = theDate
        }
        
        cell.FromLabel.text = message["from"] as? String
        cell.BodyLabel.text = message["body"] as? String

        return cell

    }
}

