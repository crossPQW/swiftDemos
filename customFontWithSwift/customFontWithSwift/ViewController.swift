//
//  ViewController.swift
//  customFontWithSwift
//
//  Created by 黄少华 on 16/4/26.
//  Copyright © 2016年 黄少华. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var datas = ["swift demos","来自造字工坊","哈哈哈哈哈哈","字体为 劲黑体,致黑体,童心体","(*^__^*) 嘻嘻……","☺️😄"]
//    var fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular"]
    var fontNames = [String]()
    var fontIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        edgesForExtendedLayout = UIRectEdge.None
        tableview.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        for family in UIFont.familyNames() {
            for font in UIFont.fontNamesForFamilyName(family) {
                fontNames.append(font)
                print(font)
            }
        }
        title = fontNames[fontIndex]
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    @IBOutlet weak var tableview: UITableView!
    @IBAction func changeFont(sender: AnyObject) {
        fontIndex = fontIndex + 1
        
        if fontIndex == fontNames.count {
            fontIndex = 0
        }
        tableview.reloadData()
        
        title = fontNames[fontIndex]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.font = UIFont(name: fontNames[fontIndex], size: 16)
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }


}

