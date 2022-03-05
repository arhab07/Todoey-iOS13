//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{

    var itemarray = [Item]()
    

    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist"))
        
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
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        loadItems( )
        
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
        
//        contex.delete(itemarray[indexPath.row])
//        itemarray.remove(at: indexPath.row)
       
//        itemarray[indexPath.row].done = !itemarray[indexPath.row].done
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
           
            let newItem = Item(context: self.contex)
            newItem.title = textField.text!
            newItem.done = false
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
        
        
         do{
           try    contex.save()
         }catch{
             print("Error saving context")
         }
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){

//
            do{
             itemarray =   try contex.fetch(request)
            }catch{
                print("Error")
            }
        
    }
    

}

extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
       
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)

    }
}




//let alert = UIAlertController(title: "Add new Todoby Item", message: "", preferredStyle: .alert)
//let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
//    // What will happen once the user clicks
//    print("Success")
//}
//alert.addAction(action)
//present(alert, animated: true, completion: nil)
