//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Arhab Muhammad on 06/03/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
   var category = [Category]()
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category[indexPath.row].name
        return cell
 
    }
    
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectCategory = category[indexPath.row]
        }
        
    }
    
    
    
    
    //MARK: - Data manipulation methods
    
    
    func saveCategories(){
        do{
          try    contex.save()
        }catch{
            print("Error saving context")
        }
        tableView.reloadData()
    }
    
    
    func loadCategory(){
        let result: NSFetchRequest = Category.fetchRequest()
        do{
        category = try contex.fetch(result)
        }catch{
            print("error")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add new Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      var textfield = UITextField()
        let alert = UIAlertController(title: "Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Category", style: .default) { (action) in
           
            let newCategory = Category(context: self.contex)
            newCategory.name = textfield.text!
            
            self.category.append(newCategory)
            self.saveCategories()
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textfield = field
            textfield.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
        
    }
    
}
