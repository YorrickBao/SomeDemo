//
//  ViewController.swift
//  SearchDemo
//
//  Created by 鲍的Mac on 2016/11/27.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var aview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bview = UIView(frame: aview.bounds)
        bview.backgroundColor = .green
        aview.addSubview(bview)
        
        aview.layer.cornerRadius = 64
        aview.layer.shadowColor = UIColor.black.cgColor
        aview.layer.shadowOffset = CGSize(width: 5, height: 5)
        aview.clipsToBounds = true
        
    }
    
    
    
}

