//
//  ViewController.swift
//  coreMotionDemo
//
//  Created by 鲍的Mac on 10/9/16.
//  Copyright © 2016 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBOutlet weak var imageview: imageView!
    
    @IBAction func btntapped(_ sender: AnyObject) {
        imageview.rotating = true
    }

}

