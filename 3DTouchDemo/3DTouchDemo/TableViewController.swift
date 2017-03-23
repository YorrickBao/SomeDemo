//
//  TableViewController.swift
//  3DTouchDemo
//
//  Created by 鲍的Mac on 2016/11/15.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let names = ["张三", "李四", "Adam", "Joey"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        // Configure the cell...
        cell.textLabel?.text = names[indexPath.row]
        cell.btn.isHidden = false
        return cell
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let dest = segue.destination as? ViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            segue.identifier == "showDetail" {
            dest.title = names[indexPath.row]
            dest.name = names[indexPath.row]
        }
        
        if let dest = segue.destination as? InfoViewController,
            segue.identifier == "showInfo" {
            print("isshowinginfo")
            dest.title = "Info"

        }
    }
    

}

extension TableViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        guard let cell = tableView.cellForRow(at: indexPath) as? TableViewCell else { return nil }
        previewingContext.sourceRect = cell.frame
        
        let btn = cell.btn!
        let clocation = view.convert(location, to: cell)
        if btn.frame.contains(clocation) {
            guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "infoVC") as? InfoViewController  else { return nil }
            vc.name = "infofofo"
            
            return vc
        } else {
            guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "labelVC") as? ViewController  else { return nil }
            vc.name = names[indexPath.row]
            
            return vc
        }
        
        

    }
}
