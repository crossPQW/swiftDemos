//
//  ViewController.swift
//  snapchatMenuWithSwift
//
//  Created by 黄少华 on 16/4/28.
//  Copyright © 2016年 黄少华. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let leftVc : LeftViewController = LeftViewController(nibName: "LeftViewController", bundle: nil)
        let CemareVc : CameraViewController = CameraViewController(nibName: "CameraViewController", bundle: nil)
        let rightVc : RightViewController = RightViewController(nibName: "RightViewController", bundle: nil)
        
        addChildViewController(leftVc)
        scrollView.addSubview(leftVc.view)
        leftVc.didMoveToParentViewController(self)
        
        addChildViewController(CemareVc)
        scrollView.addSubview(CemareVc.view)
        CemareVc.didMoveToParentViewController(self)
        
        addChildViewController(rightVc)
        scrollView.addSubview(rightVc.view)
        rightVc.didMoveToParentViewController(self)
        
        var cemaraViewFrame:CGRect = CemareVc.view.frame
        cemaraViewFrame.origin.x = view.frame.width
        CemareVc.view.frame = cemaraViewFrame
        
        var rightViewFrame :CGRect = rightVc.view.frame
        rightViewFrame.origin.x = view.frame.width * 2
        rightVc.view.frame = rightViewFrame
        
        scrollView.contentSize = CGSizeMake(view.frame.width * 3, view.frame.height)
    }

}

