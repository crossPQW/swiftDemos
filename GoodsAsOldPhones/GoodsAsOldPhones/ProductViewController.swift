//
//  ProductViewController.swift
//  GoodsAsOldPhones
//
//  Created by 黄少华 on 2017/3/31.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productNameLabel.text = product?.name
        if let imageName = product?.fullScreenimageName {
            productImageView.image = UIImage(named: imageName)
        }
    }

    @IBAction func addToCard(_ sender: Any) {
        print("hello world")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
