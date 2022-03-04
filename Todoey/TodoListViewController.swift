//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemarray = ["Buy pen" , "Buy car" , "buy Burger"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //MARK: - numberofrowinsection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    }
//MARK: - cellforRow
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                             //deqeueReusableCell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoitemCell", for: indexPath)
        cell.textLabel?.text = itemarray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // did select row
//        print(itemarray[indexPath.row])
       
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoby Items", message: "", preferredStyle: .alert )
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemarray.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}


//let alert = UIAlertController(title: "Add new Todoby Item", message: "", preferredStyle: .alert)
//let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
//    // What will happen once the user clicks
//    print("Success")
//}
//alert.addAction(action)
//present(alert, animated: true, completion: nil)
