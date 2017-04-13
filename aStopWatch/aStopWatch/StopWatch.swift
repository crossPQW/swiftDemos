//
//  StopWatch.swift
//  aStopWatch
//
//  Created by 黄少华 on 2017/4/13.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class StopWatch: NSObject {
    var counter :Double
    var timer :Timer
    
    override init() {
        counter = 0
        timer = Timer()
    }
    
}
