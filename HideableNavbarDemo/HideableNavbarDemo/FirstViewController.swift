//
//  FirstViewController.swift
//  HideableNavbarDemo
//
//  Created by 鲍的Mac on 2017/3/15.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarBgAlpha = 1
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navBarTintColor = .purple
    }

}
