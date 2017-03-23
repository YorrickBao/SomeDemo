//
//  BlueViewController.swift
//  UnwindSegueDemo
//
//  Created by 鲍的Mac on 10/1/16.
//  Copyright © 2016 com.YorrickBao. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Blue"
        // Do any additional setup after loading the view.
    }



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "backToGreenSegue" {
            print((segue.destination as? GreenViewController)?.title)
        } else if segue.identifier == "backToRootSegue" {
            print((segue.destination as? ViewController)?.title)
        }
        
    }
 

}
