//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemarray = [Item]()
    
    let dataFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        // Do any additional setup after loading the view.
//        let newItem1 = Item()
//        newItem1.title = "Find Milk"
//        itemarray.append(newItem1)
//
//        let newItem2 = Item()
//        newItem2.title = "Find Milk"
//        itemarray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Find Pen"
//        itemarray.append(newItem3)
        
        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemarray = items
        
    }
    //MARK: - numberofrowinsection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  itemarray.count
    }
    
//MARK: - cellforRow
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                             //deqeueReusableCell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoitemCell", for: indexPath)
      
        let item = itemarray[indexPath.row]
        cell.textLabel?.text = item.title
        //        ternory oprator
        cell.accessoryType = item.done ? .checkmark : .none
        
//
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // did select row
//        print(itemarray[indexPath.row])
        
       
        itemarray[indexPath.row].done = !itemarray[indexPath.row].done
         saveItem()
        
//        if itemarray[indexPath.row].done == false {
//            itemarray[indexPath.row].done = true
//        }else{
//            itemarray[indexPath.row].done = false
//        }
        
//        if  tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark{
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoby Items", message: "", preferredStyle: .alert )
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemarray.append(newItem)
            self.saveItem()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItem(){
        
        let encoder = PropertyListEncoder()
         do{
             let data = try encoder.encode(itemarray)
             try data.write(to:dataFile!)
         }catch{
             print("Error")
         }
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFile!){
            let decoider =  PropertyListDecoder()
            do{
            itemarray  = try decoider.decode([Item].self, from: data)
            }catch{
                print("Error")
            }
        }
    }
    

}





//let alert = UIAlertController(title: "Add new Todoby Item", message: "", preferredStyle: .alert)
//let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
//    // What will happen once the user clicks
//    print("Success")
//}
//alert.addAction(action)
//present(alert, animated: true, completion: nil)
