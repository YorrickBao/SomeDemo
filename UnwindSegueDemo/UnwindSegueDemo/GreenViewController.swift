//
//  GreenViewController.swift
//  UnwindSegueDemo
//
//  Created by 鲍的Mac on 10/1/16.
//  Copyright © 2016 com.YorrickBao. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Green"
    }

    @IBAction func backToGreen(segue: UIStoryboardSegue) {
        self.navigationController?.view.transform = .identity
    }
    @IBAction func gotoBlue(_ sender: Any) {
        self.navigationController?.view.transform = .init(scaleX: 0.8, y: 0.8)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endVC")
        vc.view.isOpaque = false
        UIApplication.shared.delegate?.window??.rootViewController?.present(vc, animated: false, completion: nil)
    }
    
}
