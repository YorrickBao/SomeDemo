//
//  TableViewController.swift
//  EmptyDataSetDemo
//
//  Created by YorrickBao on 2017/4/21.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class TableViewController: UITableViewController {
    
    var data: [String] = []//(1...10).map(String.init)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

}

extension TableViewController: DZNEmptyDataSetSource {
    //    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
    //        return #imageLiteral(resourceName: "avatar")
    //    }
    
    //    func buttonImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> UIImage! {
    //        switch state {
    //        case UIControlState.normal: return #imageLiteral(resourceName: "avatar")
    //        default: return nil
    //        }
    //    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Please Allow Photo Access",
                                  attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),
                                               NSForegroundColorAttributeName: UIColor.darkGray])
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let para = NSMutableParagraphStyle()
        para.lineBreakMode = .byWordWrapping
        para.alignment = .center
        
        return NSAttributedString(string: "This allows you to share photos from your library and save photos to your camera roll.",
                                  attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                                               NSForegroundColorAttributeName: UIColor.lightGray,
                                               NSParagraphStyleAttributeName: para])
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        var str: String = "Continue"
        switch state {
        case UIControlState.normal: break
        default: str = "Ok"
        }
        return NSAttributedString(string: str, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17),
                                                            NSForegroundColorAttributeName: UIColor.white])
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 20
    }
}

extension TableViewController: DZNEmptyDataSetDelegate {
//    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
//        return false
//    }
//    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
//        return true
//    }
    func emptyDataSetShouldFade(in scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        print(button.titleLabel?.text)
    }
}
