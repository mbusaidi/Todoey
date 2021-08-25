//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mohammed Al Busaidi on 24/08/2021.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [ItemCategory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textEntry = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            let newCategory = ItemCategory(context: self.context)
            
            if textEntry.text?.count != 0{
                newCategory.name = textEntry.text
                self.categoryArray.append(newCategory)
                self.saveData()
            }

        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create a new category"
            textEntry = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: TableView Data Source Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let currentCell = categoryArray[indexPath.row]
        
        cell.textLabel?.text = currentCell.name
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //MARK: TableView Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: Data Manipulation Methods
    func saveData() {
        do{
            try context.save()
        }catch{
            print("Could not save data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<ItemCategory> = ItemCategory.fetchRequest()) {
        do{
            categoryArray = try context.fetch(request)
        }catch {
            print("Could not load data \(error)")
        }
        tableView.reloadData()
    }
    
    
    

}
