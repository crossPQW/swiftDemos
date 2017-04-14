//
//  Utils.swift
//  TODO-Demo
//
//  Created by 黄少华 on 2017/4/14.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import Foundation

func dateFromString(_ date: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: date)
}

func stringFromDate(_ date: Date) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}
