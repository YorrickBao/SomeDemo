//
//  ViewController.swift
//  ChartsDemo
//
//  Created by YorrickBao on 2017/4/24.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit
import Charts
//import RealmSwift


class ViewController: UIViewController {

    @IBOutlet weak var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
    }
    
    func updateChartWithData() {
        
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
    
    
    @IBAction func btnTapped(_ sender: Any) {
        
        updateChartWithData()
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutExpo)
    }
    
    

}

