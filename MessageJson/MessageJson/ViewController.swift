//
//  ViewController.swift
//  MessageJson
//
//  Created by Pengfei Chen on 16/6/29.
//  Copyright © 2016年 Zhen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,
UISearchBarDelegate{
    
    var messages : [AnyObject] = [] //创建空数组messages
    var searchArray : [AnyObject] = [] //创建空数组searchArray
    let Timeformatter = DateFormatter() //实例化一个设置时间的类
    let TodayDate = Date() //实例化一个时间的类
    
    @IBOutlet var messageSearchBar: UISearchBar!
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet weak var editingButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    //将json文件作为字典传出
    func loadJSON(_ fileName: String) -> [String:AnyObject] {
        
        let fileUrl : URL = Bundle.main.url(forResource: fileName, withExtension: "json")!
        
        let jsonData = try? Data(contentsOf: fileUrl)
        
        var dictionary = [String:AnyObject]()
        
        if let data = jsonData {
            var json: AnyObject!
            do {
                json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject!
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
    }
    
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
    
    
    //练习冒泡排序
    static func sortArray(_ orderArray:[Int]) -> [Int]{
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
        
        //设置searchBar代理
        self.messageSearchBar.delegate = self
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        
        messageTableView.isEditing = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //设置列表有一个部分
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //判断搜索后的数组中是否有值 也就是判断是否已经搜索
        if (searchArray.isEmpty){
            //无值 则设置短信的数量为列表的行数
            return messages.count
        }
        else{
            //有值 则设置搜索出来的短信数量为行数
            return searchArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //将每一行与MessageTableViewCell类联系起来
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageTableViewCell

        //判断搜索后的数组中是否有值 也就是判断是否已经搜索
        if (searchArray.isEmpty){
            //无值 则在cell中放短信的内容
            //将每行的内容放入message
            let message = messages[(indexPath as NSIndexPath).row] as! [String : AnyObject]
            cell.FromLabel.text = message["from"] as? String
            cell.BodyLabel.text = message["body"] as? String
            
            //将日期字符串转为日期
            Timeformatter.dateFormat = "yyyy-MM-dd HH:mm"
            let timeZone = TimeZone(identifier: "UTC")
            Timeformatter.timeZone = timeZone
            let messageTime = message["time"] as! String
            let messageTime2 = Timeformatter.date(from: messageTime)
            
            //计算两日期相差的天数
            let second = TodayDate.timeIntervalSince(messageTime2!)
            let days = (Double(second)) / 86400
            
            //天数小于0.5时 显示几分几秒
            if (days < 0.5){
                Timeformatter.dateFormat = "HH:mm"
                let theTime = Timeformatter.string(from: messageTime2!)
                cell.TimeLabel.text = theTime
            }
                    
            //大于0.5小于1.5时 显示昨天
            else if (days > 0.5 && days < 1.5){
                cell.TimeLabel.text = "昨天"
            }
                    
            //大于1.5小于8时 显示星期几
            else if (days > 1.5 && days < 7){
                Timeformatter.dateFormat = "EEEE"
                let weeks = Timeformatter.string(from: messageTime2!)
                cell.TimeLabel.text = weeks
            }
                    
            //大于8时 显示年月日
            else if (days > 7){
                Timeformatter.dateFormat = "yy/M/dd"
                let theDate = Timeformatter.string(from: messageTime2!)
                cell.TimeLabel.text = theDate
            }
        }
            
        else{
            //有值 则在cell中放搜索后的短信内容
            let message = searchArray[(indexPath as NSIndexPath).row] as! [String : AnyObject]
            
            cell.FromLabel.text = message["from"] as? String
            cell.BodyLabel.text = message["body"] as? String
            
            //将日期字符串转为日期
            Timeformatter.dateFormat = "yyyy-MM-dd HH:mm"
            let timeZone = TimeZone(identifier: "UTC")
            Timeformatter.timeZone = timeZone
            let messageTime = message["time"] as! String
            let messageTime2 = Timeformatter.date(from: messageTime)
            
            //计算两日期相差的天数
            let second = TodayDate.timeIntervalSince(messageTime2!)
            let days = (Double(second)) / 86400
            
            //天数小于0.5时 显示几分几秒
            if (days < 0.5){
                Timeformatter.dateFormat = "HH:mm"
                let theTime = Timeformatter.string(from: messageTime2!)
                cell.TimeLabel.text = theTime
            }
                
            //大于0.5小于1.5时 显示昨天
            else if (days > 0.5 && days < 1.5){
                cell.TimeLabel.text = "昨天"
            }
                
            //大于1.5小于8时 显示星期几
            else if (days > 1.5 && days < 7){
                Timeformatter.dateFormat = "EEEE"
                let weeks = Timeformatter.string(from: messageTime2!)
                cell.TimeLabel.text = weeks
            }
                
            //大于8时 显示年月日
            else if (days > 7){
                Timeformatter.dateFormat = "yy/M/dd"
                let theDate = Timeformatter.string(from: messageTime2!)
                cell.TimeLabel.text = theDate
            }
        }
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //如果搜索词为空 则搜索列表保持不变
        if searchText == " " {
            self.searchArray = self.messages
        }
        else{ 
            self.searchArray = []
            for i in 0 ..< (messages.count - 1){
                let searchResult = messages[i] as! [String : AnyObject]
                //遍历字典中的值
                for value in searchResult.values{
                    //判断字典中的值是否包括搜索词
                    if String(describing: value).contains(searchText){
                        self.searchArray.append(messages[i])
                        break
                    }
                }
            }
        }
        //刷新界面
        self.messageTableView.reloadData()
    }
    
    //点击搜索键时 触发键盘隐藏
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        messageSearchBar.resignFirstResponder()
    }
    
    //点击Cancel键时 触发键盘隐藏
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        messageSearchBar.resignFirstResponder()
    }
    
    //点击编辑按钮时 进入编辑模式
    @IBAction func editingMessage(_ sender: AnyObject) {
        //标题为编辑时 变为取消
        if (editingButton.title == "编辑"){
            messageTableView.isEditing = true
            editingButton.title = "取消"
        }
        //标题为取消时 变为编辑
        else if (editingButton.title == "取消"){
            messageTableView.isEditing = false
            editingButton.title = "编辑"
        }
        messageTableView.allowsMultipleSelection = true
    }
    
    //删除多项信息
    @IBAction func deletemoreMessage(_ sender: AnyObject){
        if(messageTableView.isEditing == true){
            //选中的行
            let selectRow = messageTableView.indexPathsForSelectedRows!
            //逆向遍历数组
            for i in (0 ..< (selectRow.count)).reversed() {
                //删除数组中的对应元素
                messages.remove(at: (selectRow[i] as NSIndexPath).row)
            }
            //删除对应行信息
            messageTableView.deleteRows(at: messageTableView.indexPathsForSelectedRows!, with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    //选择所有信息
    @IBAction func selectAllMessage(_ sender: AnyObject) {
        if(messageTableView.isEditing == true){
            let bbb = messageTableView.indexPathsForVisibleRows!
            for i in 0 ..< (bbb.count - 1){
                print((bbb[i] as NSIndexPath).row)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        //当列表为编辑模式时 则进入多项选择
        if (messageTableView.isEditing == true){
            return UITableViewCellEditingStyle.init(rawValue: UITableViewCellEditingStyle.insert.rawValue | UITableViewCellEditingStyle.delete.rawValue)!
        }
        //不是编辑模式时 则单项删除（左滑得到删除选项）
        else{
            return UITableViewCellEditingStyle.delete
        }
    }
    
    //左滑删除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //点击删除键后 删除此行信息（单项删除）
        if editingStyle == UITableViewCellEditingStyle.delete {
            //删除数组中的对应元素
            messages.remove(at: (indexPath as NSIndexPath).row)
            //删除对应行
            messageTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    //把delete改成汉字”删除“
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

    
}
    
    
    
    
    
    
    



