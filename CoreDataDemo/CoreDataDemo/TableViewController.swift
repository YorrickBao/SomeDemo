//
//  TableViewController.swift
//  CoreDataDemo
//
//  Created by 鲍的Mac on 2016/10/19.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var peoples: [People]!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        self.navigationItem.rightBarButtonItem = editButtonItem
        view.addGestureRecognizer(UIScreenEdgePanGestureRecognizer())
        
        do {
            let request: NSFetchRequest<People> = People.fetchRequest()
            let results = try context.fetch(request)
            if results.count > 0 {
                peoples = results
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "People", in: context)
                let p = People(entity: entity!, insertInto: context)
                p.name = "autobyy"
                peoples = [p]
            }
        } catch let error {
            print("fetch error! \(error.localizedDescription)")
        }

        
    }
    
    func addPeople() {
        let entity = NSEntityDescription.entity(forEntityName: "People", in: context)
        let p = People(entity: entity!, insertInto: context)
        p.name = "\(Date())"
        peoples.append(p)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peoples.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath)

        cell.textLabel?.text = peoples[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.setEditing(!isEditing, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        addPeople()
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let p = peoples.remove(at: indexPath.row)
            context.delete(p)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
