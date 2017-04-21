//
//  ViewController.swift
//  AutolayoutSnapKitDemo
//
//  Created by YorrickBao on 2017/4/21.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var box = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        box.backgroundColor = UIColor.purple
        view.addSubview(box)
        box.snp.makeConstraints { (make) in
            make.height.width.equalToSuperview()
            make.center.equalTo(self.view)
        }
    }

    override func updateViewConstraints() {
        box.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
        }
        super.updateViewConstraints()
    }
    
}

