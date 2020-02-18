//
//  CollectorTableViewController.swift
//  Collector App
//
//  Created by Aileen Bull on 2/8/20.
//  Copyright © 2020 Aileen Bull. All rights reserved.
//

import UIKit

class CollectorTableViewController: UITableViewController {

    var allCollectables = [Collectable]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        getAllCollectables()
    }
    
    
    func getAllCollectables() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let collectablesFromCoreData = try? context.fetch(Collectable.fetchRequest()) {
                if let collectables = collectablesFromCoreData as? [Collectable] {
                    allCollectables = collectables
                    tableView.reloadData()
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allCollectables.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let currentCollectable : Collectable = allCollectables[indexPath.row]
        
        cell.textLabel?.text = currentCollectable.title
        if let data = currentCollectable.image {
            cell.imageView?.image = UIImage(data: data)
        }
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
//        let selectedCollectable : Collectable = allCollectables[indexPath.row]
//        performSegue(withIdentifier: "showCollectable", sender: selectedCollectable)
    }
    
 

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       if let viewCollectableVC = segue.destination as?
//    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                if let collectableToDelete = allCollectables[indexPath.row] as? Collectable {
                    context.delete(collectableToDelete)
                }
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getAllCollectables()
            }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
