//
//  Product.swift
//  GoodsAsOldPhones
//
//  Created by 黄少华 on 2017/3/31.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class Product: NSObject {
    var name: String?
    var cellImageName: String?
    var fullScreenimageName: String?
    
    init(name: String, cellImageName: String, fullScreenImageName: String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullScreenimageName = fullScreenImageName
    }
}
