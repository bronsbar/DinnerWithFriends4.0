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
    var filteredResults :[DinnerItem] = []
    var itemSelected : String = ""
    var dinner : Dinner?
    var selectedIndexPath = IndexPath()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        if let fetchedResults = fetchDinnerItems(){
            self.results = fetchedResults
        } else {
            results = []
        }
        // setup tableview for multiple selection
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.reloadData()
        
        
        
        
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        if isFiltering() {
            return filteredResults.count
        }
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dinnerItemCell", for: indexPath) as! DinnerItemTableViewCell

        // Configure the cell...
        let indexResult: DinnerItem
        if isFiltering() {
            indexResult = filteredResults[indexPath.row]
        } else {
            indexResult = results[indexPath.row]
        }
        cell.itemView.layer.cornerRadius = cell.itemView.frame.height / 2
        
        cell.itemNameLabel.text = indexResult.name
        cell.itemRatingLabel.text = String(indexResult.rating)
        if let imageData = indexResult.picture {
            let image = UIImage(data: imageData as Data)
            
            cell.itemPicture.image = image!
            cell.itemPicture.layer.cornerRadius = (cell.itemPicture.frame.height) / 2
            
        }
       
        return cell
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndexPath = indexPath
//        performSegue(withIdentifier: "itemDetailSegue", sender: nil)
//    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "itemDetailSegue", sender: nil)
    }
    
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var dinnerItemToRemove: DinnerItem?
        if isFiltering() {
            dinnerItemToRemove = filteredResults[indexPath.row]
        } else  {
            dinnerItemToRemove = results[indexPath.row]
        }
        guard editingStyle == .delete else { return}
        managedContext.delete(dinnerItemToRemove!)
        do {
            try managedContext.save()
           // tableView.deleteRows(at: [indexPath], with: .automatic)
            if let fetchedResults = fetchDinnerItems() {
                self.results = fetchedResults
            } else { results = []
                
            }
            searchController.searchBar.text = ""
            tableView.reloadData()
        } catch let error as NSError {
            print ("saving error : \(error), description : \(error.userInfo)")
            
        }
    }
    

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
    // MARK - Private instance methods
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContentForSearchText(_ searchText: String, scope : String = "All") {
        filteredResults = results.filter({(dinnerItem : DinnerItem) ->Bool in
            guard let dinnerItemName = dinnerItem.name else {return false}
            return dinnerItemName.lowercased().contains(searchText.lowercased())
        })
    tableView.reloadData()
        
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search in \(itemSelected) Items"
       
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
    }
    func fetchDinnerItems() -> [DinnerItem]? {
        let itemListFetch : NSFetchRequest<DinnerItem> = DinnerItem.fetchRequest()
        itemListFetch.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(DinnerItem.category), itemSelected])
        
        do {
            results = try managedContext.fetch(itemListFetch)
        } catch let error as NSError {
            print ("Fetch error: \(error) description \(error.userInfo)")
            return nil
        }
        return results
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as? UINavigationController
        let dinnerItemDetailVC = destinationVC?.topViewController as? DinnerItemDetailTableViewController
        dinnerItemDetailVC?.managedContext = managedContext
        dinnerItemDetailVC?.itemSelected = itemSelected
        if segue.identifier == "addItemDetailSegue" {
            // setup if new item added
            dinnerItemDetailVC?.newItem = true
            
        }
        if segue.identifier == "itemDetailSegue" {
            
            if isFiltering(){
                dinnerItemDetailVC?.item = filteredResults[selectedIndexPath.row]
            } else {
                dinnerItemDetailVC?.item = results[selectedIndexPath.row]
            }
        }
    }
    
    @IBAction func unwindFromDinnerItemDetail(segue: UIStoryboardSegue) {
        
        tableView.reloadData()
        
    }
    
    
}
extension itemListTableViewController: UISearchResultsUpdating {
    // MARK - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}
extension itemListTableViewController {
    
   
}
