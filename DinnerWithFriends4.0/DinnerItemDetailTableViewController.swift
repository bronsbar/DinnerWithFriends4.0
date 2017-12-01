//
//  DinnerItemDetailTableViewController.swift
//  DinnerWithFriends4.0
//
//  Created by Bart Bronselaer on 30/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit
import CoreData

class DinnerItemDetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var managedContext : NSManagedObjectContext!
    var item : DinnerItem?
    var itemSelected : String = ""
    
    // MARK: - Outlets
    @IBOutlet weak var pictureLabel: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var urlLabel: UITextField!
    @IBOutlet weak var ratingLabel: UITextField!
    @IBOutlet weak var notesLabel: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func textEditingChanged (_ sender: UITextField) {
        updateSaveButtonStatus()
    }
    // Select a picture
    @IBAction func pictureTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "photo library", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true
                    , completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        present(alertController, animated: true, completion: nil)
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pictureLabel.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Preload the category
        categoryLabel.text = itemSelected
        // Update SaveButton status
        updateSaveButtonStatus()

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveDinnerItemSegue" {
            item = DinnerItem(context: managedContext)
            item?.name = nameLabel.text!
            switch itemSelected {
            case "Starter" : item?.category = "Starter"
            case "Main Course" : item?.category = "Main Course"
            case "Dessert" : item?.category = "Dessert"
            case "Apperitive" : item?.category = "Apperitive"
            case "Red Wine" : item?.category = "Red Wine"
            case "White Wine" : item?.category = "White Wine"
            default : break
            }
            // prepare image for storing
            if let picture = pictureLabel.image {
                let pictureData = UIImagePNGRepresentation(picture)
                item?.picture = pictureData as NSData?
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print ("Save error: \(error), description: \(error.userInfo)")
            }
            let destinationVC = segue.destination as! itemListTableViewController
            destinationVC.results.append(item!)
        }
    }
}

// MARK - Helper functions
extension DinnerItemDetailTableViewController {
    func updateSaveButtonStatus () {
        let nameText = nameLabel.text ?? ""
        let categoryText = categoryLabel.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !categoryText.isEmpty
        
    }
}
