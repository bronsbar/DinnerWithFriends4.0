//
//  DinnerDetailTableViewController.swift
//  DinnerWithFriends3.0
//
//  Created by Bart Bronselaer on 29/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit
import CoreData

class DinnerDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    var managedContext : NSManagedObjectContext!
    var dinner : Dinner?
    var categories :[String] = ["Starter","Main Course","Dessert","Apperitive","White Wine","Red Wine"]
    var categorySelected = ""
    
    @IBOutlet weak var friendsLabel: UITextField!
    
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var starterLabel: UITextField!
    
    @IBOutlet weak var mainLabel: UITextField!
    
    @IBOutlet weak var dessertLabel: UITextField!
    
    @IBOutlet weak var appertiveLabel: UITextField!
    
    @IBOutlet weak var whiteLabel: UITextField!
    
    @IBOutlet weak var redLabel: UITextField!
    
    
    
    @IBOutlet weak var notesLabel: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
        // update saveButton status
        updateSaveButtonStatus()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
     let categorySelectedIndex = 3 * (indexPath.section - 1) + (indexPath.row)
        categorySelected = categories[categorySelectedIndex]
        performSegue(withIdentifier: "itemListSegue", sender: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemListSegue" {
            let destinationVc = segue.destination as? UINavigationController
            let endVc = destinationVc?.topViewController as! itemListTableViewController
            // set title
            endVc.title = categorySelected
            // propagate the managedContxt
            endVc.managedContext = managedContext
            // pass categorySelected to itemSelected
            endVc.itemSelected = categorySelected
            // pass dinner to itemListTableViewController
            endVc.dinner = dinner
                }
            }
    @IBAction func unwindFromitemListTableViewController (segue: UIStoryboardSegue) {
        // do nothing for the time being
    }

    @IBAction func textEditingChanged (_ sender: UITextField) {
        updateSaveButtonStatus()
    }
}
    // MARK - Helper functions
extension DinnerDetailTableViewController {
    func updateSaveButtonStatus () {
        let friendsText = friendsLabel.text ?? ""
        let dateText = dateLabel.text ?? ""
        let mainText = mainLabel.text ?? ""
        saveButton.isEnabled = !friendsText.isEmpty && !dateText.isEmpty && !mainText.isEmpty
        
    }
}
