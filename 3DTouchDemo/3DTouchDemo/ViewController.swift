//
//  ViewController.swift
//  3DTouchDemo
//
//  Created by 鲍的Mac on 2016/11/15.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = name ?? ""
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override var previewActionItems: [UIPreviewActionItem] {
        let action = UIPreviewAction(title: "abc", style: .default) { (action, vc) in
            print(action.title)
            print(vc)
            print(self.name ?? "")
        }
        return [action]
    }

}
