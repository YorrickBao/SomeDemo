//
//  ViewController.swift
//  ChartsDemo
//
//  Created by YorrickBao on 2017/4/24.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit
import Charts
import RealmSwift


class ViewController: UIViewController {

    @IBOutlet weak var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let pCounts = getPersonInDataBase()
        for i in 0..<pCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(pCounts[i].count))
            dataEntries.append(dataEntry)
        }
        
        let arr = (0...100).map { BarChartDataEntry(x: Double($0), y: Double($0 * $0)) }
        
        let chartDataSet = BarChartDataSet(values: arr, label: "Person Count")
        chartDataSet.barBorderWidth = 0
        chartDataSet.barShadowColor = UIColor.orange
        let chartData = BarChartData(dataSet: chartDataSet)

        chartView.data = chartData
        
        chartView.rightAxis.addLimitLine(ChartLimitLine(limit: 5000, label: "Target"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
  
    func getPersonInDataBase() -> Results<Person> {
        do {
            let realm = try Realm()
            return realm.objects(Person.self)
        } catch let err as NSError {
            fatalError(err.localizedDescription)
        }
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        abd()
        updateChartWithData()
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutExpo)
    }
    
    func abd() {
        let p = Person()
        p.count = Int(arc4random() % 100)
        p.save()
    }
    

}

