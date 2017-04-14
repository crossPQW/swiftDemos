//
//  ViewController.swift
//  TODO-Demo
//
//  Created by 黄少华 on 2017/4/14.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

var todos: [ToDoModel] = []

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = [ToDoModel(id: "1", image: "child-selected", title: "asdasdasd", date: dateFromString("2014-10-30")!),
                 ToDoModel(id: "2", image: "shopping-cart-selected", title: "ergsdgsdg", date: dateFromString("2014-10-30")!),
                 ToDoModel(id: "3", image: "phone-selected", title: "ertertry", date: dateFromString("2014-10-30")!),
                 ToDoModel(id: "4", image: "travel-selected", title: "cvbcvncvcvb", date: dateFromString("2014-10-30")!)]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configCellWithTodoModel(_ cell: UITableViewCell, todo: ToDoModel) {
        let imageViwe = cell.viewWithTag(11) as! UIImageView
        let titleLabel = cell.viewWithTag(12) as! UILabel
        let dateLabel = cell.viewWithTag(13) as! UILabel
        
        imageViwe.image = UIImage(named: todo.image)
        titleLabel.text = todo.title
        dateLabel.text =  stringFromDate(todo.date)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        configCellWithTodoModel(cell, todo: todos[(indexPath as NSIndexPath).row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
}
