//
//  ViewController.swift
//  bucketList
//
//  Created by Sheetal Desai on 11/5/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit
import CoreData

struct detailsSender {
    var name:String = String()
    var iPath:IndexPath? = nil
}

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var sender = detailsSender()
        sender.name = "add"
        performSegue(withIdentifier: "ItemDetailsSegue", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        fetchAllItems()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].item
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        var sender = detailsSender()
        sender.name = "edit"
        sender.iPath = indexPath
        performSegue(withIdentifier: "ItemDetailsSegue", sender: sender)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
            print("Success")
        } catch {
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func fetchAllItems() {
        print("FetchAllItems")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let results = try (managedObjectContext.fetch(request))
            print("Got results")
            items = results as! [BucketListItem]
        } catch {
            print("\(error)")
        }

    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didPressCancelButton button: UIBarButtonItem) {
        print("cancel recieved")
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingItem item: String, at indexPath: IndexPath?) {
        dismiss(animated: true, completion: nil)
        if let path = indexPath {
            items[path.row].item = item
        }
        else {
            let i = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            i.item = item
            items.append(i)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let addItemController = navController.topViewController as! AddItemTableViewController
       
        let s = sender as! detailsSender
        
        addItemController.delegate = self
        
        if segue.identifier == "ItemDetailsSegue" {
            if s.name == "edit" {
                addItemController.indexPath = s.iPath
                addItemController.editItem = items[s.iPath!.row].item
            }
        }
        
    }


}

