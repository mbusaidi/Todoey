//
//  ViewController.swift
//  Todoey
//
//  Created by Mohammed Al Busaidi on 21/08/2021.
//

import UIKit

class TodoListViewController: UITableViewController{

    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
    
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
    }
    //MARK - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let currentItem = itemArray[indexPath.row]
        
        cell.textLabel?.text = currentItem.title
        
        cell.accessoryType = currentItem.done ? .checkmark : .none
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK - Add new items
    
        
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textEntry = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // What will happen once the user adds the add button action
            let newItem = Item()
            
            newItem.title = textEntry.text!
            newItem.done = false
            
            
            self.itemArray.append(newItem)
            
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            
            textEntry = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
}

