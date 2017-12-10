//
//  DinnerTableViewController.swift
//  DinnerWithFriends3.0
//
//  Created by Bart Bronselaer on 28/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit
import CoreData

class DinnerTableViewController: UITableViewController {

    
    @IBOutlet weak var namelabel: UITextField!
    
    var managedContext: NSManagedObjectContext!
    var fetchRequest: NSFetchRequest<Dinner>?
    var dinners: [Dinner] = []
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Find or Create
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel,
            let fetchRequest = model.fetchRequestTemplate(forName: "FetchRequest") as? NSFetchRequest<Dinner> else {return}
        self.fetchRequest = fetchRequest
        do {
            let resultsFromFetch = try managedContext.fetch(fetchRequest)
            if resultsFromFetch.count > 0 {
                // already data in Dinner Core Data
                dinners = resultsFromFetch
            } else {
                // no data found in Dinner, create one sample
               
                // prepare image
                let sampleDinner = Dinner(context: managedContext)
                let image = UIImage(named: "pizza")!
                let imageData = UIImagePNGRepresentation(image)!
                sampleDinner.picture = NSData(data: imageData)
                // date
                sampleDinner.date = NSDate()
                // rating
                sampleDinner.rating = Int16(5)
                // save context
                try managedContext.save()
                
                dinners.append(sampleDinner)
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
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
        return dinners.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DinnerCell", for: indexPath) as! DinnerTableViewCell

        // Configure the cell...
        let dinner = dinners[indexPath.row] 
        let dinnerDate = dinner.date as Date?
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        cell.dinnerDateLabel.text = dateFormatter.string(from: dinnerDate!)
      //  let dinnerRating = dinner.rating
       
       // cell. text = String(dinnerRating)
        
        let imageData = dinner.picture as Data?
        cell.dinnerPicture.image = UIImage(data: imageData!)
        cell.dinnerPicture.layer.cornerRadius = cell.dinnerPicture.frame.height / 2
        cell.dinnerViewLabel.layer.cornerRadius = cell.dinnerViewLabel.frame.height / 2

        return cell
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
    
    @IBAction func unwindFromDinnerDetail(segue: UIStoryboardSegue) {
        
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dinnerAdd" {
            let destinationVC = segue.destination as? UINavigationController
            let dinnerDetailVC = destinationVC?.topViewController as? DinnerDetailTableViewController
            dinnerDetailVC?.managedContext = managedContext
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    

}
