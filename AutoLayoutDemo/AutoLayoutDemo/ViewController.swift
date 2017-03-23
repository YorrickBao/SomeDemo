//
//  ViewController.swift
//  AutoLayoutDemo
//
//  Created by 鲍的Mac on 2017/1/22.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAutolyaout()
    }

    func setupAutolyaout() {
        let viewMap = ["greenView" : greenView, "redView" : redView]
        // 采用自动布局
        for v in viewMap.values {
            v?.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        var format = "[greenView(==redView)]"
//        
//        var cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewMap)
//        NSLayoutConstraint.activate(cons)
        
        var format = "|-8-[greenView(==redView)]-8-|"
        
        var cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewMap)
        NSLayoutConstraint.activate(cons)
        
        format = "V:|-8-[greenView(==redView)]-0-[redView]-8-|"
        
        cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewMap)
        NSLayoutConstraint.activate(cons)
        
//        format = "V:[greenView(==redView)]"
//        
//        cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewMap)
//        NSLayoutConstraint.activate(cons)
        
        format = "|-8-[redView]-8-|"
        
        cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewMap)
        NSLayoutConstraint.activate(cons)
        
        view.needsUpdateConstraints()
    }


}

