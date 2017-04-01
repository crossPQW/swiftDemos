//
//  ViewController.swift
//  UIKitDemos
//
//  Created by 黄少华 on 2017/4/1.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit
import Social


class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSeg: UISegmentedControl!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var workTextfield: UITextField!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var straightSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func salaryChanged(_ sender: Any) {
        let slider = sender as! UISlider
        let i = Int(slider.value)
        salaryLabel.text = "$\(i)K"
    }

    @IBAction func tapButton(_ sender: Any) {
        if (nameTextField.text == "" || workTextfield.text == "" || salaryLabel.text == "") {
            showAlert("Info Miss", message: "Please fill out the form", buttonTitle: "OK")
            return
        }
        
        let name:String! = nameTextField.text
        let work:String! = workTextfield.text
        let salary:String! = salaryLabel.text
        
        //age
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        let now = Date()
        let components = (gregorian as NSCalendar?)?.components(NSCalendar.Unit.year, from: birthdayPicker.date, to: now, options: [])
        let age:Int! = components?.year
        
        var interestedIn:String! = "Women"
        if genderSeg.selectedSegmentIndex == 0 && !straightSwitch.isOn {
            interestedIn = "Men"
        }
        if genderSeg.selectedSegmentIndex == 1 && straightSwitch.isOn {
            interestedIn = "Women"
        }
        
        let content = "Hi, I am \(name!). As a \(age!)-year-old \(work!) earning \(salary!)/year, I am interested in \(interestedIn!). Feel free to contact me!"
        tweetSLCVC(content)
    }
    
    fileprivate func showAlert(_ title:String, message:String, buttonTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func tweetSLCVC(_ tweet:String) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let tweetController:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            self.present(tweetController, animated: true, completion: nil)
        }else{
            showAlert("Twitter Unavailable", message: "Please configure your twitter account on device", buttonTitle: "OK")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
}

