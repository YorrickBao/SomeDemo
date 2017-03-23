//
//  ViewController.swift
//  BlueToothDemo
//
//  Created by 鲍的Mac on 2016/11/1.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit
import CoreBluetooth

public let serviceUUID          = CBUUID(string: "E20A39F4-73F5-4BC4-A12F-17D1AD07A961")//DDD9A957-5C70-46A7-AF11-C61501C1D629
public let characteristicUUID   = CBUUID(string: "08590F7E-DB05-467E-8757-72F6FAEB13D4")//C2DDA085-A344-4895-8EAE-4CF06E068B10

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Mode"
    }
}

