//
//  ProductsTableViewController.swift
//  GoodsAsOldPhones
//
//  Created by 黄少华 on 2017/3/31.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {

    fileprivate var products: [Product]?
    fileprivate let indentifier = "productCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = [Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullScreenImageName: "phone-fullscreen1"),
                    Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullScreenImageName: "phone-fullscreen1"),
                    Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullScreenImageName: "phone-fullscreen1"),
                    Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullScreenImageName: "phone-fullscreen1")
        ]
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let products = products {
            return products.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath)

        cell.textLabel?.text = products?[(indexPath as NSIndexPath).row].name
        
        if let imageName = products?[(indexPath as NSIndexPath).row].cellImageName {
            cell.imageView?.image = UIImage(named: imageName)
        }
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showProduct" {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let productVC = segue.destination as? ProductViewController
            {
                productVC.product = products?[(indexPath as NSIndexPath).row]
            }
        }
    }
    

}
