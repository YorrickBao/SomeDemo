//
//  ViewController.swift
//  UnwindSegueDemo
//
//  Created by 鲍的Mac on 10/1/16.
//  Copyright © 2016 com.YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Root"
        
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")
        print(path)
    }

    @IBAction func backToRoot(segue: UIStoryboardSegue) {
        
    }



}

