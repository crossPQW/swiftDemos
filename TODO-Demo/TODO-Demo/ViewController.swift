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
        navigationItem.leftBarButtonItem = editButtonItem
        todos = [ToDoModel(id: "1", image: "child-selected", title: "asdasdasd", date: dateFromString("2014-10-30")!),
                 ToDoModel(id: "2", image: "shopping-cart-selected", title: "ergsdgsdg", date: dateFromString("2014-10-30")!),
                 ToDoModel(id: "3", image: "phone-selected", title: "ertertry", date: dateFromString("2014-10-30")!),
                 ToDoModel(id: "4", image: "travel-selected", title: "cvbcvncvcvb", date: dateFromString("2014-10-30")!)]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTODO" {
            let vc = segue.destination as! DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            if let indexPath = indexPath {
                vc.todo = todos[(indexPath as NSIndexPath).row]
            }
        }
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
        if todos.count != 0 {
            return todos.count
        }else {
            let emptyLabel: UILabel = UILabel()
            emptyLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            emptyLabel.text = "No data is currently available"
            emptyLabel.textColor = UIColor.blue
            emptyLabel.numberOfLines = 0
            emptyLabel.textAlignment = NSTextAlignment.center
            emptyLabel.font = UIFont(name: "Palatino-Italic", size: 20)
            
            self.tableView.backgroundView = emptyLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            return 0
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            todos.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: (sourceIndexPath as NSIndexPath).row)
        todos.insert(todo, at: (destinationIndexPath as NSIndexPath).row)
    }
}
