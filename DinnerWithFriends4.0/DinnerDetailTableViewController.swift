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
    private var dinner : Dinner?
    private var categories :[String] = ["Starter","Main Course","Dessert","Apperitive","White Wine","Red Wine"]
    private var categorySelected = ""
    
    @IBOutlet private weak var friendsLabel: UITextField!
    @IBOutlet private weak var dateLabel: UITextField!
    @IBOutlet private weak var starterLabel: UITextField!
    @IBOutlet private weak var mainLabel: UITextField!
    @IBOutlet private weak var dessertLabel: UITextField!
    @IBOutlet private weak var appertiveLabel: UITextField!
    @IBOutlet private weak var whiteLabel: UITextField!
    @IBOutlet private weak var redLabel: UITextField!
    @IBOutlet private weak var notesLabel: UITextView!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    @IBAction func unwindFromitemListTableViewController (segue: UIStoryboardSegue) {
        // do nothing for the time being
    }
    
    @IBAction func textEditingChanged (_ sender: UITextField) {
        updateSaveButtonStatus()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // update saveButton status
        updateSaveButtonStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // Navigate when an accessoryButton is tapped
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
     let categorySelectedIndex = 3 * (indexPath.section - 1) + (indexPath.row)
        categorySelected = categories[categorySelectedIndex]
        performSegue(withIdentifier: "itemListSegue", sender: nil)
    }

    // Preparation before segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemListSegue" {
            let destinationVc = segue.destination as? UINavigationController
            let endVc = destinationVc?.topViewController as! itemListTableViewController
            // propagate the managedContxt
            endVc.managedContext = managedContext
            // pass categorySelected to itemSelected
            endVc.itemSelected = categorySelected
            // set title
            endVc.title = categorySelected
            // pass dinner to itemListTableViewController
            endVc.dinner = dinner
                }
            }

}
    // MARK - Helper functions
extension DinnerDetailTableViewController {
    
   private func updateSaveButtonStatus() {
        let friendsText = friendsLabel.text ?? ""
        let dateText = dateLabel.text ?? ""
        let mainText = mainLabel.text ?? ""
        saveButton.isEnabled = !friendsText.isEmpty && !dateText.isEmpty && !mainText.isEmpty
        
    }
}
