//
//  ViewController.swift
//  PinCellWhenTop
//
//  Created by 鲍的Mac on 2017/1/8.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topScrollView: TopScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 40
        tableView.sectionFooterHeight = 8
        
        
        
        topScrollView.topScrollViewDelegate = self
        let rect = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: 0, section: 1)).frame
        topScrollView.frame = rect
        topScrollView.backgroundColor = .white
        tableView.addSubview(topScrollView)
        
        tableView.contentInset = UIEdgeInsets(top: rect.height, left: 0, bottom: 0, right: 0)
//        tableView.frame.origin.y += rect.height
//        tableView.frame.size.height -= rect.height
    }
    
    func asd() {
        numOfRow = 0
        tableView.reloadSections([1], with: UITableViewRowAnimation.automatic)
    }
    func bsd() {
        numOfRow = 6
        tableView.reloadSections([1], with: UITableViewRowAnimation.automatic)
    }
    var numOfRow = 4
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            asd()
        }
        if indexPath.row == 2 {
            bsd()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return numOfRow
        default:
            return 19
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: 40)
        header.backgroundColor = .red
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var text = "Row: \(indexPath.row)"
        
        if indexPath.section == 1, indexPath.row == 0 {
            text += " 预约状态"
        }
        
        if indexPath.section == 2, indexPath.row == 0 {
            text += " 预约详情"
        }
        
        cell.textLabel?.text = text
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let rect = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: 0, section: 1)).frame
        var rect2 = view.convert(rect, from: tableView)
        let navHeight = navigationController!.navigationBar.frame.maxY

        if rect2.origin.y < navHeight {
            rect2.origin.y = navHeight
        }

        rect2 = view.convert(rect2, to: tableView)
        topScrollView.frame = rect2
        print(topScrollView.frame.width)
        print(view.frame.width)
        
        guard let cellRect = tableView.cellForRow(at: IndexPath(row: 0, section: 2))?.frame else { return }
        let cellRect2 = view.convert(cellRect, from: tableView)
        if cellRect2.origin.y < navHeight {
            topScrollView.scrollToButtonWith(101)
            topScrollView.shadowViewScrollTo(0.5)
        } else {
            topScrollView.scrollToButtonWith(100)
            topScrollView.shadowViewScrollTo(0)
        }
        
    }
}

extension ViewController: TopScrollViewDelegate {
    func scrollToView(_ index: Int) {
        let indexPath = IndexPath(row: 0, section: index + 1)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
