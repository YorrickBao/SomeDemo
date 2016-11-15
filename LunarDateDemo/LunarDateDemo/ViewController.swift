//
//  ViewController.swift
//  LunarDateDemo
//
//  Created by 鲍的Mac on 2016/10/28.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit
//import SSLunarDate

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let a = SSLunarDate(date: Date())
        print(a?.string() ?? "nil")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

