//
//  itemListTableViewController.swift
//  DinnerWithFriends3.0
//
//  Created by Bart Bronselaer on 30/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit
import CoreData


class itemListTableViewController: UITableViewController {
    
    var managedContext : NSManagedObjectContext!
    var results: [DinnerItem] = []
    var itemSelected : String = ""
    var dinner : Dinner?
    var selectedIndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemListFetch : NSFetchRequest<DinnerItem> = DinnerItem.fetchRequest()
        itemListFetch.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(DinnerItem.category), itemSelected])

        do {
        results = try managedContext.fetch(itemListFetch)
        } catch let error as NSError {
            print ("Fetch error: \(error) description \(error.userInfo)")
        }
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dinnerItemCell", for: indexPath)

        // Configure the cell...
        let indexResult = results[indexPath.row]
        cell.textLabel?.text = indexResult.name
        cell.detailTextLabel?.text = String(indexResult.rating)
        if let imageData = indexResult.picture {
            let image = UIImage(data: imageData as Data)
            cell.imageView?.image = image!
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "itemDetailSegue", sender: nil)
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
        
        let destinationVC = segue.destination as? UINavigationController
        let dinnerItemDetailVC = destinationVC?.topViewController as? DinnerItemDetailTableViewController
        dinnerItemDetailVC?.managedContext = managedContext
        dinnerItemDetailVC?.itemSelected = itemSelected
        if segue.identifier == "addItemDetailSegue" {
            // setup if item added
            
        }
        if segue.identifier == "itemDetailSegue" {
            dinnerItemDetailVC?.item = results[selectedIndexPath.row]
        }
    }
    
    @IBAction func unwindFromDinnerItemDetail(segue: UIStoryboardSegue) {
        
        tableView.reloadData()
        
    }
    

}
