//
//  ViewController.swift
//  LocalVideoPlayerBySwift
//
//  Created by 黄少华 on 16/4/26.
//  Copyright © 2016年 黄少华. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var datas = [
        Video(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        Video(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        Video(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
        Video(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
        Video(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
        Video(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
    ]
    
    var playerController = AVPlayerViewController()
    var player           = AVPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview.rowHeight = 220
        title = "AVPLAYER"
        edgesForExtendedLayout = UIRectEdge.None
    }

    @IBAction func play(sender: AnyObject) {
        let path = NSBundle.mainBundle().pathForResource("emoji zone", ofType: "mp4")
        
        player = AVPlayer(URL: NSURL(fileURLWithPath: path!))
        
        playerController.player = player
        
        self.presentViewController(playerController, animated: true) {
            self.playerController.player?.play()
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! VideoCell
        cell.bgImage.image = UIImage(named: datas[indexPath.row].image)
        cell.title.text = datas[indexPath.row].title
        cell.source.text = datas[indexPath.row].source
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let path = NSBundle.mainBundle().pathForResource("emoji zone", ofType: "mp4")
//        
//        player = AVPlayer(URL: NSURL(fileURLWithPath: path!))
//        
//        playerController.player = player
//        
//        self.presentViewController(playerController, animated: true) { 
//            self.playerController.player?.play()
//        }
//    }

}

