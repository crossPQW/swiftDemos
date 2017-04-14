//
//  ToDoModel.swift
//  TODO-Demo
//
//  Created by 黄少华 on 2017/4/14.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class ToDoModel: NSObject {
    var id: String
    var image: String
    var title: String
    var date: Date
    
    init(id: String,image: String,title: String,date: Date){
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}
