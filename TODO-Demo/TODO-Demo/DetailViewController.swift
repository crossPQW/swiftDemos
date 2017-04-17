//
//  DetailViewController.swift
//  TODO-Demo
//
//  Created by 黄少华 on 2017/4/14.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var childBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var shopBtn: UIButton!
    @IBOutlet weak var travalBtn: UIButton!

    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    var todo: ToDoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let todo = todo {
            title = "Edit Todo"
            if todo.image == "child-selected" {
                childBtn.isSelected = true
            } else if todo.image == "phone-selected"{
                phoneBtn.isSelected = true
            }
            else if todo.image == "shopping-cart-selected"{
                shopBtn.isSelected = true
            }
            else if todo.image == "travel-selected"{
                travalBtn.isSelected = true
            }
            titleTf.text = todo.title
            date.setDate(todo.date, animated: true)
        }else{
            title = "New Todo"
            childBtn.isSelected = true
        }
    }
    
    @IBAction func done(_ sender: Any) {
        var image = ""
        if childBtn.isSelected {
            image = "child-selected"
        }
        else if phoneBtn.isSelected {
            image = "phone-selected"
        }
        else if shopBtn.isSelected {
            image = "shopping-cart-selected"
        }
        else if travalBtn.isSelected {
            image = "travel-selected"
        }
        if let todo = todo {
            todo.image = image
            todo.title = titleTf.text!
            todo.date = date.date
        }else {
            let uuid = UUID().uuidString
            todo = ToDoModel(id: uuid, image: image, title: titleTf.text!, date: date.date)
            todos.append(todo!)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectChild(_ sender: AnyObject) {
        resetBtns()
        childBtn.isSelected = true
    }
    
    @IBAction func selectPhone(_ sender: AnyObject) {
        resetBtns()
        phoneBtn.isSelected = true
    }
    
    @IBAction func selectShoppingCart(_ sender: AnyObject) {
        resetBtns()
        shopBtn.isSelected = true
    }
    
    @IBAction func selectTravel(_ sender: AnyObject) {
        resetBtns()
        travalBtn.isSelected = true
    }
    
    func resetBtns() {
        childBtn.isSelected = false
        phoneBtn.isSelected = false
        shopBtn.isSelected = false
        travalBtn.isSelected = false
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
