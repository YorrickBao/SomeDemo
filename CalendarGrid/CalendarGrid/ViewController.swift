//
//  ViewController.swift
//  GridView
//
//  Created by 鲍的Mac on 2017/1/12.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gridView: GridView!
    
    let rowHeader = (1...5).map{ Date().addingTimeInterval(Double($0) * 24 * 60 * 60) }
    let colHeader = ["10:30-\n11:30", "1:30-\n5:30", "10:30-\n11:30", "1:30-\n5:30", "10:30-\n11:30", "1:30-\n5:30"].map { s -> UILabel in
        let label = UILabel()
        label.text = s
        label.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }
    let labels = Array<String>(repeating: "预约", count: 30).map { s -> UILabel in
        let label = UILabel()
        label.text = s
        label.backgroundColor = UIColor(red:0.57, green:0.12, blue:0.15, alpha:1.00)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.delegate = self
        gridView.dataSource = self
        print("viewdidload")
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewdidappear")
    }

    @IBAction func btnTapped(_ sender: Any) {
        gridView.reloadData()
    }

}

extension ViewController: GridViewDelegate {
    func gridView(_ gridView: GridView, didTapCellAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension ViewController: GridViewDataSource {
    var numberOfRow: Int {
        return colHeader.count
    }
    var numberOfCol: Int {
        return rowHeader.count
    }
    
    func gridView(_ gridView: GridView, rowHeaderAt col: Int) -> UIView {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-DD"
        let text = formatter.string(from: rowHeader[col])
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        return label
    }
    
    func gridView(_ gridView: GridView, colHeaderAt row: Int) -> UIView {
        return colHeader[row]
    }
    
    func gridView(_ gridView: GridView, cellAt indexPath: IndexPath) -> GridCell {
        switch indexPath.row {
        case let x where x % 3 == 0:
            return GridCell.value("预约", uiEnabled: true, backgroundColor: .red, textColor: .white)
        case let x where x % 3 == 1:
            return GridCell.value("已满", uiEnabled: false, backgroundColor: UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1), textColor: .white)
        default:
            return GridCell.empty
        }
        
    }
}
